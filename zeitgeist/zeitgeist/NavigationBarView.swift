//
//  NavigationView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
    
    init() {
        
        // For unselected
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.white
        
    }
    
    var body: some View {
        TabView {
           HomeView()
             .tabItem {
                Image(systemName: "house").font(Font.system(size: 30, weight: .regular))
            }
           Search()
             .tabItem {
                Image(systemName: "magnifyingglass").font(Font.system(size: 30, weight: .regular))
                }
            ProfileView()
               .tabItem {
                Image(systemName: "person").font(Font.system(size: 30, weight: .regular))
                }
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
