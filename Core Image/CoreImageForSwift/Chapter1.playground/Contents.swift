//: ## Introducing Core Image

import UIKit

let mona = CIImage(image: UIImage(named: "monalisa.jpg")!)!

let mono = CIFilter(name: "CIPhotoEffectMono",
                    parameters: [
        kCIInputImageKey: mona])!.outputImage!

let falseColor = CIFilter(name: "CIFalseColor",
                          parameters: [
        kCIInputImageKey: mono,
        "inputColor0": CIColor(red: 0.15, green: 0.15, blue: 1),
        "inputColor1": CIColor(red: 1, green: 1, blue: 0.5)])!.outputImage!

let vignette = CIFilter(name: "CIVignette",
                        parameters: [
        kCIInputImageKey: falseColor,
        kCIInputRadiusKey: 4,
        kCIInputIntensityKey: 4])?.outputImage







// end
