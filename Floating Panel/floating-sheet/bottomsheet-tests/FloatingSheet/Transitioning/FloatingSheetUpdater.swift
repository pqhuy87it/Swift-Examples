//
//  FloatingSheetUpdater.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

struct FloatingSheetUpdater {
    private let sheetView: FloatingSheetView
    private let context: FloatingSheetContext
    private let state: FloatingSheetState

    init?(sheetView: FloatingSheetView?, to currentState: FloatingSheetState?) {
        guard
            let currentState = currentState,
            let sheetView = sheetView,
            let context = sheetView.currentContext()
        else {
            return nil
        }


        self.sheetView = sheetView
        self.context = context
        self.state = currentState
    }

    func update() {
        print("FloatingSheetUpdater.update(), state = \(state.id)")
        updatePosition()
        updateOverlayAppearance()
        updateShadow()
        updateMask()
    }

    func updatePosition() {
        let newFrame = state.position.frame(context)
        sheetView.floatingView.frame = newFrame
        sheetView.contentContainer.frame = sheetView.floatingView.bounds
        sheetView.contentView?.frame = sheetView.contentContainer.bounds
        sheetView.floatingView.layoutIfNeeded()
    }

    func updateOverlayAppearance() {
        sheetView.overlayView.backgroundColor = state.appearance.overlayColor
    }

    func updateMask() {
        let frame = state.mask.mask(context) ?? sheetView.floatingView.bounds
        let cornerRadius = state.appearance.cornerRadius

        sheetView.maskingView.layer.cornerRadius = cornerRadius
        sheetView.maskingView.frame = frame

        sheetView.shadowView.layer.cornerRadius = cornerRadius
        sheetView.shadowView.frame = frame
    }

    func updateShadow() {
        sheetView.shadowView.layer.shadowColor = state.appearance.shadow.color?.cgColor
        sheetView.shadowView.layer.shadowOffset = state.appearance.shadow.offset
        sheetView.shadowView.layer.shadowRadius = state.appearance.shadow.radius
        sheetView.shadowView.layer.shadowOpacity = state.appearance.shadow.opacity
    }
}
