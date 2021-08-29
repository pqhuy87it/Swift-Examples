
import Foundation
import UIKit

public func textSpacing(_ labelSelected : UILabel, spacing: CGFloat) {
    
    let attributedString = labelSelected.attributedText as? NSMutableAttributedString
    attributedString?.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, (attributedString?.length)!))
    
}
