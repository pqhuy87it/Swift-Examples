//
//  RoundedRect.swift
//  UIBezierPath
//
//  Created by vit on 04.06.2023.
//

import SwiftUI

struct RoundedRect: Shape {
    private var radii: CGSize
    private var corners: UIRectCorner
    
    init(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        self.radii = CGSize(width: radius, height: radius)
        self.corners = corners
    }

    init(radii: CGSize, corners: UIRectCorner = .allCorners) {
        self.radii = radii
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(rect: rect, byCorners: corners, cornerRadii: radii)
        return Path(path.cgPath)
    }
}

struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRect(radius: 500).fill(.green)
    }
}
