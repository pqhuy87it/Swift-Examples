//
//  DShapeView.swift
//  SwiftUI Path
//
//  Created by Luiz Pedro Franciscatto Guerra on 21/07/22.
//

import SwiftUI

struct DShapeView: View {
    var body: some View {
        NavigationView {
            DShape()
                .stroke(Color.accentColor, lineWidth: 5)
                .frame(width: 100, height: 100)
                .offset(x: 25, y: -25)
                .navigationTitle(Text("Banner Shape View"))
        }
    }
}

struct DShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addCurve(
                to: CGPoint(x: 0, y: rect.height),
                control1: CGPoint(x: rect.width*0.75, y: 0),
                control2: CGPoint(x: rect.width*0.75, y: rect.height))
            path.addLine(to: .zero)
            path.closeSubpath()
        }
    }
}

struct DShapeView_Previews: PreviewProvider {
    static var previews: some View {
        DShapeView()
    }
}
