//
//  ContentView.swift
//  UIBezierPath
//
//  Created by vit on 04.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRect(radii: CGSize(width: 0, height: 0))
                .fill(.gray)
                .frame(width: 300, height: 300)
            
            RoundedRect(radii: CGSize(width: 50, height: 100))
                .fill(.green)
                .frame(width: 200, height: 200)
            
            RoundedRect(radius: 50, corners: [.bottomRight, .topLeft])
                .fill(.blue)
                .frame(width: 100, height: 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
