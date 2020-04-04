//
//  ContentView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 19.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ItemNodeView()
        //NavigationBarView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView()
              .environment(\.colorScheme, .light)
           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}
