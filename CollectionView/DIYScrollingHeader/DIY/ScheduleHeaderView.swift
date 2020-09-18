//
//  ScheduleHeaderView.swift
//  RWDevCon
//
//  Created by Mic Pringle on 06/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class ScheduleHeaderView: UICollectionReusableView {
  
  @IBOutlet private weak var backgroundImageView: UIView!
  @IBOutlet private weak var backgroundImageViewHeightLayoutConstraint: NSLayoutConstraint!
  
  @IBOutlet private weak var foregroundImageView: UIView!
  @IBOutlet private weak var foregroundImageViewHeightLayoutConstraint: NSLayoutConstraint!
  
  private var backgroundImageViewHeight: CGFloat = 0
  private var foregroundImageViewHeight: CGFloat = 0
  private var previousHeight: CGFloat = 0
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundImageViewHeight = backgroundImageView.bounds.height
    foregroundImageViewHeight = foregroundImageView.bounds.height
  }
  
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    let attributes = layoutAttributes as! DIYLayoutAttributes
        let height = attributes.frame.height
    if previousHeight != height {
      backgroundImageViewHeightLayoutConstraint.constant = backgroundImageViewHeight - attributes.deltaY
      foregroundImageViewHeightLayoutConstraint.constant = foregroundImageViewHeight + attributes.deltaY
      previousHeight = height
    }
  }
  
}
