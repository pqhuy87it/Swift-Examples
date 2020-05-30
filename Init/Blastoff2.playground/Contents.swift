//: Swift Tutorial: Initialization In Depth, Part 2
//: http://www.raywenderlich.com/121603/swift-tutorial-initialization-part-2

import Cocoa

class LaunchSite {
  let name: String
  let coordinates: (String, String)

  init?(name: String, coordinates: (String, String)) {
    self.name = name
    self.coordinates = coordinates

    guard !name.isEmpty && !coordinates.0.isEmpty && !coordinates.1.isEmpty else {
      return nil
    }
  }
}

class RocketComponent {
  let model: String
  let serialNumber: String
  let reusable: Bool

  static func decomposeIdentifier(_ identifier: String) ->
    (model: String, serialNumber: String)? {
      let identifierComponents = identifier.components(separatedBy: "-")
      guard identifierComponents.count == 2 else {
        return nil
      }
      return (model: identifierComponents[0], serialNumber: identifierComponents[1])
  }

  // Init #1a - Designated
  init(model: String, serialNumber: String, reusable: Bool) {
    self.model = model
    self.serialNumber = serialNumber
    self.reusable = reusable
  }

  // Init #1b - Convenience
  convenience init(model: String, serialNumber: String) {
    self.init(model: model, serialNumber: serialNumber, reusable: false)
  }

  // Init #1c - Convenience
  convenience init?(identifier: String, reusable: Bool) {
    guard let (model, serialNumber) = RocketComponent.decomposeIdentifier(identifier) else {
      return nil
    }
    self.init(model: model, serialNumber: serialNumber, reusable: reusable)
  }

}

let payload = RocketComponent(model: "RT-1", serialNumber: "234", reusable: false)
let fairing = RocketComponent(model: "Serpent", serialNumber: "0")

let component = RocketComponent(identifier: "R2-D21", reusable: true)
let nonComponent = RocketComponent(identifier: "", reusable: true)

class Tank: RocketComponent {
  var encasingMaterial: String

  // Init #2a - Designated
  init(model: String, serialNumber: String, reusable: Bool, encasingMaterial: String) {
    self.encasingMaterial = encasingMaterial
    super.init(model: model, serialNumber: serialNumber, reusable: reusable)
  }

  // Init #2b - Designated
  override init(model: String, serialNumber: String, reusable: Bool) {
    self.encasingMaterial = "Aluminum"
    super.init(model: model, serialNumber: serialNumber, reusable: reusable)
  }

}

let fuelTank = Tank(model: "Athena", serialNumber:"003", reusable: true)
let liquidOxygenTank = Tank(identifier: "LOX-012", reusable: true)

class LiquidTank: Tank {
  let liquidType: String

  // Init #3a - Designated
  init(model: String, serialNumber: String, reusable: Bool,
    encasingMaterial: String, liquidType: String) {
      self.liquidType = liquidType
      super.init(model: model, serialNumber: serialNumber, reusable: reusable,
        encasingMaterial: encasingMaterial)
  }

  // Init #3b - Convenience
  convenience init(model: String, serialNumberInt: Int, reusable: Bool,
    encasingMaterial: String, liquidType: String) {
      let serialNumber = String(serialNumberInt)
      self.init(model: model, serialNumber: serialNumber, reusable: reusable,
        encasingMaterial: encasingMaterial, liquidType: liquidType)
  }

  // Init #3c - Convenience
  convenience init(model: String, serialNumberInt: Int, reusable: Int,
    encasingMaterial: String, liquidType: String) {
      let reusable = reusable > 0
      self.init(model: model, serialNumberInt: serialNumberInt, reusable: reusable,
        encasingMaterial: encasingMaterial, liquidType: liquidType)
  }

  // Init #3d - Convenience
  convenience override init(model: String, serialNumber: String, reusable: Bool) {
    self.init(model: model, serialNumber: serialNumber, reusable: reusable,
      encasingMaterial: "Aluminum", liquidType: "LOX")
  }

  // Init #3e - Convenience
  convenience override init(model: String, serialNumber: String, reusable: Bool,
    encasingMaterial: String) {
      self.init(model: model, serialNumber: serialNumber,
        reusable: reusable, encasingMaterial: "Aluminum")
  }

  // Init #3f - Convenience
  convenience init?(identifier: String, reusable: Bool, encasingMaterial: String,
    liquidType: String) {
      guard let (model, serialNumber) = RocketComponent.decomposeIdentifier(identifier) else {
        return nil
      }
      self.init(model: model, serialNumber: serialNumber, reusable: reusable,
        encasingMaterial: encasingMaterial, liquidType: liquidType)
  }

}



let rp1Tank = LiquidTank(model: "Hermes", serialNumberInt: 5, reusable: 1,
  encasingMaterial: "Aluminum", liquidType: "LOX")

let loxTank = LiquidTank(identifier: "LOX-1", reusable: true)

let athenaFuelTank = LiquidTank(identifier: "Athena-9", reusable: true,
  encasingMaterial: "Aluminum", liquidType: "RP-1")

