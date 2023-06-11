//
//  FloatingSheetPosition.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

struct FloatingSheetPosition {
    let frame: (_ context: FloatingSheetContext) -> CGRect

    static func custom(_ frame: @escaping (_ context: FloatingSheetContext) -> CGRect) -> FloatingSheetPosition {
        .init(frame: frame)
    }

    static func insets(_ insets: UIEdgeInsets) -> FloatingSheetPosition {
        .init { context in
            let frame = CGRect(origin: .zero, size: context.availableSize)
            return frame.inset(by: insets)
        }
    }

    static func full() -> FloatingSheetPosition {
        .init { context in
            CGRect(origin: .zero, size: context.availableSize)
        }
    }

    static func aboveBottomEdge(
        relativeHeight: CGFloat,
        extendsBelowBottom: Bool = false
    ) -> FloatingSheetPosition {
        .init { context in
            let heigth = context.availableSize.height * relativeHeight
            return FloatingSheetPosition.aboveBottomEdge(
                absoluteHeight: heigth,
                extendsBelowBottom: extendsBelowBottom
            )
            .frame(context)
        }
    }

    static func aboveBottomEdge(
        absoluteHeight: CGFloat,
        extendsBelowBottom: Bool = false
    ) -> FloatingSheetPosition {
        .init { context in
            CGRect(
                x: 0,
                y: context.availableSize.height - absoluteHeight,
                width: context.availableSize.width,
                height: extendsBelowBottom
                    ? context.availableSize.height
                    : absoluteHeight
            )
        }
    }

    static func belowBottomEdge() -> FloatingSheetPosition {
        .init { context in
            CGRect(
                x: 0,
                y: context.availableSize.height,
                width: context.availableSize.width,
                height: context.availableSize.height
            )
        }
    }

    func inseted(_ insets: UIEdgeInsets) -> FloatingSheetPosition {
        .init { context in
            self.frame(context).inset(by: insets)
        }
    }
}
