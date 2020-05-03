//
//  ContentView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 19.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
// Main struct view
struct ContentView: View {
    // Default view at app launch
    var body: some View {
        NavigationBarView()
    }
}
// For canvas preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in light mode
           ContentView()
              .environment(\.colorScheme, .light)
            // Preview in dark mode
           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}
