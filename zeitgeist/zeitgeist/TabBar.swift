//
//  TabBar.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 7.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass").font(Font.system(size: 30, weight: .regular))
            }
            ReservationList()
                .tabItem {
                    Image(systemName: "list.dash").font(Font.system(size: 30, weight: .regular))
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
