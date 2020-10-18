//: Playground - noun: a place where people can play

import UIKit

protocol TextPresentable {
    var text: String { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
}

protocol SwitchPresentable {
    var switchOn: Bool { get }
    var switchColor: UIColor { get }
}

protocol ImagePresentable {
    var imageName: String { get }
}

/*
class SwitchWithTextTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var switchToggle: UISwitch!
    @IBOutlet private weak var iconView: UIImageView!
    
    // Too long and a bit confusing!
    func configure<T where T: TextPresentable, T: SwitchPresentable, T: ImagePresentable>(presenter: T) {
        
        label.text = presenter.text
        
        switchToggle.on = presenter.switchOn
        switchToggle.onTintColor = presenter.switchColor
        
        iconView.image = UIImage(named: presenter.imageName)
    }
}
*/

// Protocol Composition!!
typealias SwitchWithTextViewPresentable = TextPresentable & SwitchPresentable & ImagePresentable

class SwitchWithTextTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var switchToggle: UISwitch!
    @IBOutlet private weak var iconView: UIImageView!
    
    func configure(presenter: SwitchWithTextViewPresentable) {
        
        label.text = presenter.text
        
        switchToggle.isOn = presenter.switchOn
        switchToggle.onTintColor = presenter.switchColor
        
        iconView.image = UIImage(named: presenter.imageName)
    }
}
