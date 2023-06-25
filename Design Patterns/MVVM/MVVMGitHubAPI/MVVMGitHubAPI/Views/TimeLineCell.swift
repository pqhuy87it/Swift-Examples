//
//  TimeLineCell.swift
//  MVVMGitHubAPI
//
//  Created by 大西玲音 on 2021/04/04.
//

import UIKit

final class TimeLineCell: UITableViewCell {
    
    static var toString: String {
        return String(describing: self)
    }
    static let id = TimeLineCell.toString
    static func nib() -> UINib {
        return UINib(nibName: TimeLineCell.toString, bundle: nil)
    }
    private var iconView: UIImageView!
    private var nickNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
        nickNameLabel = UILabel()
        nickNameLabel.font = .systemFont(ofSize: 15)
        contentView.addSubview(nickNameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(x: 15,
                                y: 15,
                                width: 45,
                                height: 45)
        iconView.layer.cornerRadius = iconView.frame.size.width / 2
        nickNameLabel.frame = CGRect(x: iconView.frame.maxX + 15,
                                     y: iconView.frame.origin.y,
                                     width: contentView.frame.width - iconView.frame.maxX - 15 * 2,
                                     height: 15)
        
    }
    
    func setNickName(nickName: String) {
        nickNameLabel.text = nickName
    }
    
    func setIcon(icon: UIImage) {
        iconView.image = icon
    }
    
}
