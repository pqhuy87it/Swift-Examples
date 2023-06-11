//
//  FloatingSheetMask.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

struct FloatingSheetMask {
    let mask: (_ context: FloatingSheetContext) -> CGRect?

    static func none() -> FloatingSheetMask {
        .init { _ in
            nil
        }
    }

    static func insets(_ insets: UIEdgeInsets) -> FloatingSheetMask {
        .init { context in
            context.contentView.bounds.inset(by: insets)
        }
    }

    static func aroundView(_ view: UIView) -> FloatingSheetMask {
        .init { context in
            view.convert(view.bounds, to: context.contentView)
        }
    }

    static func aboveView(_ view: UIView) -> FloatingSheetMask {
        .init { context in
            let minY = view.convert(view.bounds.origin, to: context.contentView).y
            let maskCropedFromTop = context.contentView.bounds.inset(
                by: .init(top: minY, left: 0, bottom: 0, right: 0)
            )
            return maskCropedFromTop
        }
    }

    func inseted(_ insets: UIEdgeInsets) -> FloatingSheetMask {
        .init { context in
            self.mask(context)?.inset(by: insets)
        }
    }
}
