//
//  FloatingSheetAppearance.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

struct FloatingSheetAppearance {
    struct Shadow {
        let color: UIColor?
        let offset: CGSize
        let radius: CGFloat
        let opacity: Float

        static let none = Shadow(
            color: nil,
            offset: .zero,
            radius: 0,
            opacity: 0
        )
    }

    var cornerRadius: CGFloat = 0
    var overlayColor: UIColor = .clear
    var shadow: Shadow = .none
}
