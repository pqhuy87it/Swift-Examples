# Dependency Injection: Introduction

## Definition

Dependency injection is a technique whereby one object (or static method) supplies the dependencies of another object. A dependency is an object that can be used (a service). By [Bhavya Karia](https://www.freecodecamp.org/news/a-quick-intro-to-dependency-injection-what-it-is-and-when-to-use-it-7578c84fa88f/). There are generally 4 patterns of Dependency Injection. Its also an attempt at implementing the D in SOLID principles which says: High level modules should not depend on low level modules. Both should depend on abstractions. B, Abstractions should not depend upon details. Details should depend on abstractions. 

## Technique 1: Initializer/Constructor DI
A lot of people use this method without even acknowledging it as Dependency Injection. Here, the dependency is passed in the class' initializer. Below, we pass our Dependency object (dependency) to our class Initializer class through it's init. Then we can use it in other places in the class InitializerClass. This technique becomes complicated when our InitializerClass has a lot of dependencies. Our init method will grow so big. 

```
class InitializerClass {

    private var dependency: Dependency

    init(_ dependency: Dependency) {
        self.dependency = dependency
    }

    func useDependency() {
        self.dependency.useMyMethod()
    }
}
```

## Technique 2: Property DI

In classes like View Controllers, we cannot use Initializer DI mainly because we mostly do not care about initializers for them (not that they do not exist). Instead, we pass dependencies as properties (eg. how we pass data to particular View Controllers generally). In the example below, we successfully pass Dependency() to InitializerController.

```
class InitializerController: UIViewController {
    var dependency: Dependency!
}

//In another controller or class,
let initController = InitializerController()
initController.dependency = Dependency()
```


## Technique 3: Factory DI:
The Factory DI pattern combines both patterns we've used above into something different but elegant. Factories enable you to fully decouple the usage and creation of an object and therefore helps in refactoring. We create our Factory as a protocol (so we can implement it in different ways even during testing). BaseDIFactory then implements it and returns our object. If we want to create our controller, we instantiate our BaseDIFactory and ask it to generate the controller for us. 

```
protocol DIFactory {
    func generateDependency() -> Dependency
    func generateInitializerController() -> InitializerController
}

class BaseDIFactory: DIFactory {

    func generateDependency() -> Dependency {
        return Dependency()
    }

    func generateInitializerController() -> InitializerController {
        let initController = InitializerController()
        initController.dependency = generateDependency()
        return initController
    }
}

let factory = BaseDIFactory()
let controller = factory.generateInitializerController()
// Our controller already comes with it's dependency 
```

## Technique 4: Service Locator DI
The Service Locator serves as a registry of dependencies for a given dependencies and it consists of 2 basic parts. The Registry and the Locator/Resolver. The registry registers our dependencies, then the locator / resolver helps us find our dependencies. Optionally, you can include a Container (A container keep your registrations at one particular place so your code isnt all over the place).  The simplest form of the Service Locator pattern is below


```
protocol ServiceLocator {
    func resolve<T>() -> T?
}

final class DIServiceLocator: ServiceLocator {

    static let shared = DIServiceLocator()

    private lazy var services: Dictionary<String, Any> = [:]
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ?
            "\(some)" : "\(type(of: some))"
    }

    func register<T>(_ service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
```
The above protocol and implementation contains the registrar (first method) and the resolver (second method).

To register using our locator,
```
let locator = DIServiceLocator()
let dependency = Dependency()
locator.register(dependency)
```

To resolve our registered dependency,
```
let locator = DIServiceLocator()
guard let dependency: Dependency = locator.resolve() else { return }
```

## Libraries
There are libraries around like [Resolver](https://github.com/hmlongco/Resolver), [Swinject](https://github.com/Swinject/Swinject) and [Cleanse](https://github.com/square/Cleanse) which create use cases based on the Service Locator pattern for much more complex situations so you can check them out.
In the controllers in this module, I use Resolver and Swinject.. each with it's view model and Controller in it's simplest form so its easy to understand.

### To use Resolver..
  1. Register services (as shown in MockingProject/Helpers/DIHelpers/AppDelegate+Injection)
```
extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerAPIManager()
        registerViewModel()
    }
}

extension Resolver {
    public static func registerAPIManager() {
        register { APIManager() }
    }

    public static func registerViewModel() {
        register { ResolverViewModel(manager: self.resolve()) }
    }
}
```

 2. Resolve ViewModel in Controller by...
```
class ResolverController: UIViewController, Resolving {
    private var viewModel: ResolverViewModel = Resolver.resolve()
}
```

### To use Swinject.
 1. Create a container which contain all your registrations
```
class SwinjectContainer {

    static let sharedContainer = SwinjectContainer()
    let container = Container()

    private init() {
        setupDefaultContainers()
    }

    private func setupDefaultContainers() {
        container.register(APIManager.self, factory: { _ in APIManager() })

        container.register(HomeViewModelProtocol.self, factory: { resolver in
            return SwinjectViewModel(manager: resolver.resolve(APIManager.self)!)
        })
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        let mainContainer = SwinjectContainer.sharedContainer.container

        defaultContainer.storyboardInitCompleted(SwinjectController.self) { _, controller in
            controller.viewModel = mainContainer.resolve(HomeViewModelProtocol.self)
        }
    }
}

```

 2. Call Container init method in AppDelegate's didFinishLaunchingWithOptions method
```
_ = SwinjectContainer.sharedContainer
```

 3. Resolving will occur automatically now

## Extras
For extensive reading, check out 

- [Modern Dependency Injection with Swift](https://medium.com/better-programming/modern-dependency-injection-in-swift-952286b308be)
- [iOS Dependency Injection Using Swinject](https://medium.com/flawless-app-stories/ios-dependency-injection-using-swinject-9c4ceff99e41)
- [Advanced Dependency Injection on iOS with Swift 5](https://www.vadimbulavin.com/dependency-injection-in-swift/)
- [Dependency Injection Strategies in Swift](https://quickbirdstudios.com/blog/swift-dependency-injection-service-locators/)
- [Swift 5.1 Takes Dependency Injection to the Next Level](https://medium.com/better-programming/taking-swift-dependency-injection-to-the-next-level-b71114c6a9c6)
