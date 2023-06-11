//
//  FloatingSheetState.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

struct FloatingSheetState {
    let id: String
    var position: FloatingSheetPosition = .full()
    var mask: FloatingSheetMask = .none()
    var appearance: FloatingSheetAppearance = .init()
    var interaction: FloatingSheetInteractions = .init()

    init(id: String) {
        self.id = id
    }

    static let `default` = FloatingSheetState(id: "default")
}

extension FloatingSheetState: Equatable, Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
