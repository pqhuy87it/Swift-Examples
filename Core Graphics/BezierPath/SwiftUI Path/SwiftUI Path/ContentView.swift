//
//  ContentView.swift
//  SwiftUI Path
//
//  Created by Luiz Pedro Franciscatto Guerra on 20/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SquareView()
                .tabItem {
                    Label("Square", systemImage: "1.square.fill")
                }
            DShapeView()
                .tabItem {
                    Label("D Shape", systemImage: "2.circle.fill")
                }
            BannerView()
                .tabItem {
                    Label("Banner", systemImage: "pencil.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
