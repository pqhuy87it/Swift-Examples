//
//  DAOPanelHeader.swift
//  DAOFloatingPanel
//
//  Created by Ray Dan on 2021/2/13.
//

import UIKit

open class DAOPanelHeader: UILabel {
  // MARK: - Init
  init(title: String?) {
    super.init(frame: .zero)
    
    setupUI(with: title)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setupUI(with title: String?) {
    backgroundColor = .white
    clipsToBounds = false
    font = UIFont.systemFont(ofSize: 16)
    textColor = .black
    textAlignment = .center
    layer.zPosition = 1
    dropShadow()
    
    text = title
  }
  
  // MARK: - Utility
  private func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowRadius = 1.5
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
