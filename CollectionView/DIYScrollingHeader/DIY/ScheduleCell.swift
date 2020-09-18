//
//  ScheduleCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 09/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var separatorViewHeightLayoutConstraint: NSLayoutConstraint!
  
  var session: Session? {
    didSet {
      if let session = session {
        titleLabel.text = session.title
        timeAndRoomLabel.text = session.roomAndTime
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorViewHeightLayoutConstraint.constant = 0.5
  }
  
}
