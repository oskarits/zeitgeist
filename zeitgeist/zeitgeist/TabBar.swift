//
//  TabBar.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 7.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedView = 0
    var view = ["Search", "Reservations"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedView, label: Text("")) {
                ForEach(0..<view.count) { index in
                    Text(self.view[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())

            if ( view[selectedView] == "Search") {
                SearchView()
            }
            if ( view[selectedView] == "Reservations") {
                ReservationList()
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

/*
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
 */
