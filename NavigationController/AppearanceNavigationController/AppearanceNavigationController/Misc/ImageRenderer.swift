
import Foundation
import UIKit

class ImageRenderer: NSObject {

    class func renderImageOfColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(size);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x:0, y:0, width: size.width, height: size.height));
        
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output
    }
}
