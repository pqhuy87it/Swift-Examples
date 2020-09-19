//
//  PaintingBrushSettingsView.swift
//  DrawingBoard
//
//  Created by ZhangAo on 15-3-28.
//  Copyright (c) 2015年 zhangao. All rights reserved.
//

import UIKit

class PaintingBrushSettingsView : UIView {
    
    var strokeWidthChangedBlock: ((_ strokeWidth: CGFloat) -> Void)?
    var strokeColorChangedBlock: ((_ strokeColor: UIColor) -> Void)?
    
    @IBOutlet private var strokeWidthSlider: UISlider!
    @IBOutlet private var strokeColorPreview: UIView!
    @IBOutlet private var colorPicker: RGBColorPicker!
    
    override var backgroundColor: UIColor? {
        didSet {
            self.strokeColorPreview.backgroundColor = self.backgroundColor
            self.colorPicker.setCurrentColor(self.backgroundColor!)
            
            super.backgroundColor = oldValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.strokeColorPreview.layer.borderColor = UIColor.black.cgColor
        self.strokeColorPreview.layer.borderWidth = 1
        
        self.colorPicker.colorChangedBlock = {
            [unowned self] (color: UIColor) in
            
            self.strokeColorPreview.backgroundColor = color
            if let strokeColorChangedBlock = self.strokeColorChangedBlock {
                strokeColorChangedBlock(color)
            }
        }
        
        self.strokeWidthSlider.addTarget(self, action: #selector(strokeWidthChanged), for:.valueChanged)
    }
    
    @objc func strokeWidthChanged(slider: UISlider) {
        if let strokeWidthChangedBlock = self.strokeWidthChangedBlock {
            strokeWidthChangedBlock(CGFloat(slider.value))
        }
    }
}
