//
//  TabBar.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 7.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    // Selected tab index value
    @State private var selectedView = 0
    // Selectable tab name
    var view = ["Search", "Reservations"]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Selects view from tab
            Picker(selection: $selectedView, label: Text("")) {
                // Lists tabs
                ForEach(0..<view.count) { index in
                    Text(self.view[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            // Shows SearchView when search tab is selected (default)
            if ( view[selectedView] == "Search") {
                SearchView()
            }
            // Shows ReservationView when reservations tab is selected
            if ( view[selectedView] == "Reservations") {
                ReservationList().onDisappear(){ // Returns TabBar to a default state
                    self.selectedView = 0
                }.onAppear(){
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
