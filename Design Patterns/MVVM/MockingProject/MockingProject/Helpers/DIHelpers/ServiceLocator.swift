//
//  DIServiceLocator.swift
//  Development
//
//  Created by Fitzgerald Afful on 21/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation

protocol ServiceLocator {
    func resolve<T>() -> T?
}

final class DIServiceLocator: ServiceLocator {

    static let shared = DIServiceLocator()

    private lazy var services: [String: Any] = [:]
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ?
            "\(some)" : "\(type(of: some))"
    }

    func register<T>(_ service: T) {
        let key = typeName(some: T.self)
        print("Registering \(key)")
        services[key] = service
        print(services)
    }

    func resolve<T>() -> T? {
        let key = typeName(some: T.self)
        print("Resolving \(key)")
        return services[key] as? T
    }
}
