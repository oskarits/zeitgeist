//
//  ProfileInfo.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 17.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileInfo: View {
    // Selected tab index value
    @State private var selectedView = 0
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // Fetches core data using CheckoutNode NSManagedObject class
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    // Selectable tab name
    var view = ["Reservations", "Purhcases"]

    var body: some View {
        VStack {
            // Default name
            Text("userName")
                .font(.largeTitle)
            // Fetches user idString(email)
            Text(isLoggedInResults[0].idString)
                .font(.subheadline)
                .foregroundColor(.gray)
            // Fetches user size
            HStack {
                Text("sizeTitle")
                Text(isLoggedInResults[0].size)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            Divider()
            // Selects view from tab
            Picker(selection: $selectedView, label: Text("")) {
                // Lists tabs
                ForEach(0..<view.count) { index in
                    Text(self.view[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            // Shows ReservationView()/ReservationList() when reservations tab is selected (default)
            if ( view[selectedView] == "Reservations") {
                VStack {
                    HStack {
                        Text("reservTitle")
                        .fontWeight(.bold)
                        .font(.title)
                        Text("(\(fetchedResults.count))")
                        .fontWeight(.bold)
                        .font(.title)
                    }
                    
                    NavigationLink(destination: ReservationList()) {
                        VStack {
                            ReservationView()
                        }
                    }
                }
            }
            // Shows ShoppingHistoryView when purhcases tab is selected
            if ( view[selectedView] == "Purhcases") {
                Text("Previous purhcases: (\(checkoutResults.count))")
                    .fontWeight(.bold)
                    .font(.title)
                ShoppingHistoryView().onDisappear(){
                    self.selectedView = 0
                }
            }
        }
    }
}


// For canvas preview
struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo()
    }
}
