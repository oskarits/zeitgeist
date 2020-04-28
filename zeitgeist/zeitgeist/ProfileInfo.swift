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
    @State private var selectedView = 0
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    var view = ["Reservations", "Purhcases"]

    var body: some View {
        VStack {
            Text("Jane Doe")
                .font(.largeTitle)
            Text(isLoggedInResults[0].idString)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Size: " + isLoggedInResults[0].size)
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
            Picker(selection: $selectedView, label: Text("")) {
                ForEach(0..<view.count) { index in
                    Text(self.view[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            if ( view[selectedView] == "Reservations") {
                VStack {
                    Text("Reservations: (\(fetchedResults.count))")
                        .fontWeight(.bold)
                        .font(.title)
                    NavigationLink(destination: ReservationList()) {
                        VStack {
                            ReservationView()
                        }
                    }
                }
            }
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



struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo()
    }
}
