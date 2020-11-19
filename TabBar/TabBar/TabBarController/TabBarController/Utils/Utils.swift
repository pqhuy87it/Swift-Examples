//
//  Utils.swift
//  Mumo
//
//  Created by Andy Boariu on 24/02/15.
//  Copyright (c) 2015 Mumo. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    // MARK: - Public Methods
    /// Simply load image async
    class func displayImage(imgToDisplay: UIImage?,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?) {
        
        let queue = DispatchQueue(label: "TabBarController")
        
        queue.async {
            DispatchQueue.main.async(execute: { () -> Void in
                //=>    Set image
                imageView.image     = imgToDisplay
                
                if roundCorners == true {
                    //=>    Set round corners
                    imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                    imageView.layer.masksToBounds     = true
                }
                
                if borderWidth > 0 {
                    imageView.layer.borderWidth = borderWidth
                    if let borderColorTemp = borderColor {
                        imageView.layer.borderColor = borderColorTemp.cgColor
                    }
                }
            })
        }
    }
    
    /// Simply load image async, from URL
    class func displayImageFromURL(urlImage: URL!,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?) {
            
        let queue = DispatchQueue(label: "TabBarController")
        
        queue.async {
            
            do {
                let dataProfileImage = try Data(contentsOf: urlImage)
                
                if let imgToDisplay = UIImage(data: dataProfileImage) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        //=>    Set image
                        imageView.image     = imgToDisplay
                        
                        //=>    Set round corners
                        if roundCorners == true {
                            imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                            imageView.layer.masksToBounds     = true
                        }
                        
                        //=>    Set border width and color
                        if borderWidth > 0 {
                            imageView.layer.borderWidth = borderWidth
                            if let borderColorTemp = borderColor {
                                imageView.layer.borderColor = borderColorTemp.cgColor
                            }
                        }
                    })
                }
            } catch {
                
            }
        }
    }
    
    /// Simply load image async, from URL, with completion
    class func displayImageFromURL(urlImage: URL!,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?,
        withCompletion completion: @escaping (_ imageFromURL: UIImage?) -> Void) {
        
        let queue = DispatchQueue(label: "TabBarController")
        
        queue.async {
            do {
                let dataProfileImage = try Data(contentsOf: urlImage)
                
                if let imgToDisplay = UIImage(data: dataProfileImage) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        //=>    Set image
                        imageView.image     = imgToDisplay
//                        completion(imgToDisplay)
                        
                        //=>    Set round corners
                        if roundCorners == true {
                            imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                            imageView.layer.masksToBounds     = true
                        }
                        
                        //=>    Set border width and color
                        if borderWidth > 0 {
                            imageView.layer.borderWidth = borderWidth
                            if let borderColorTemp = borderColor {
                                imageView.layer.borderColor = borderColorTemp.cgColor
                            }
                        }
                    })
                } else {
                    completion(nil)
                }
            } catch {
                
            }
        }
    }
}

// MARK: - EXTENSIONS Methods

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension Array
{
    func contains<T>(obj: T) -> Bool where T : Equatable
    {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    mutating func removeObject<U: Equatable>(object: U)
    {
        var index: Int?
        for (idx, objectToCompare) in self.enumerated()
        {
            if let to = objectToCompare as? U
            {
                if object == to
                {
                    index = idx
                }
            }
        }
        
        if(index != nil)
        {
            self.remove(at: index!)
        }
    }
}

extension TimeInterval {
    
    /// Get the total amount of hours that this Time Interval instance holds
    var hours: Int {
        return Int(floor(((self / 60.0) / 60.0)))
    }
    /// Get the hour component, up to 23 hours
    public var hourComponent: Int {
        return self.hours % 24
    }
    /// Get the total amount of minutes that this Time Interval instance holds
    var minutes: Int {
        return Int(floor(self / 60.0))
    }
    /// Get the minutes component, up to 59 minutes
    public var minuteComponent: Int {
        return minutes - (hours * 60)
    }
    /// Get the total amount of seconds that this Time Interval instance holds
    var seconds: Int {
        return Int(floor(self))
    }
    /// Get the seconds component, up to 59 seconds
    public var secondComponent: Int {
        return seconds - (minutes * 60)
    }
    /// Get the total amount of miliseconds that this Time Interval instance holds
    var miliseconds: Int64 {
        return Int64((seconds * 1000) + milisecondComponent)
    }
    /// Get the miliseconds component
    public var milisecondComponent: Int {
        var (_, fracPart) = modf(self)
        return Int(fracPart * 100)
    }
    
    ///
    /// Get this NSTimeInterval instance as a formatted string
    /// - parameter useFraction: Optionally appends the miliseconds to the string
    ///
    public func getFormattedInterval(miliseconds useFraction: Bool) -> String {
        let hoursStr = hourComponent < 10 ? "0" + String(hourComponent) : String(hourComponent)
        let minutesStr = minuteComponent < 10 ? "0" + String(minuteComponent) : String(minuteComponent)
        let secondsStr = secondComponent < 10 ? "0" + String(secondComponent) : String(secondComponent)
        var counter = "\(hoursStr):\(minutesStr):\(secondsStr)"
        
        if useFraction {
            let milisecondsStr = milisecondComponent < 10 ? "0" + String(milisecondComponent) : String(milisecondComponent)
            counter += ".\(milisecondsStr)"
        }
        
        return counter
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return  self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur += 1
        }
        return nil
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
