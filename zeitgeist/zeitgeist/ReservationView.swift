//
//  ReservationView.swift
//  zeitgeist
//
//  Created by Oskari Sieranen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI

struct ReservationView: View {
    @ObservedObject var networkingManager = NetworkingManager()
    
    var body: some View {
        VStack {
            Text("Reserved Items")
                .font(.system(size: 26, weight: .regular))
                .foregroundColor(Color.orange)
            NavigationView {
                List {
                    self.ReservedItems
                }
            }
        }
    }
    
    var ReservedItems: some View {
        // TODO replace with a list of the reserved items
        ForEach(networkingManager.clothingList.items) { item in
            NavigationLink(destination:
                VStack(alignment: .leading) {
                    Text(item.brand).font(.largeTitle)
                    Text(item.size)
                    Text(item.condition)
                    Text(item.description)
                    Text("\(item.price) €")
                        .font(.system(size: 20))
                        .foregroundColor(Color.orange)
                    // Notify user when the reservation has bene interacted with
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "checkmark")
                            Text("Accept")}.foregroundColor(.green).padding()
                        Button(action: {}) {
                            Image(systemName: "trash")
                            Text("Decline")}.foregroundColor(.red).padding()
                    }.padding()
                        .font(.title)
                    
            }) {
                
                VStack(alignment: .leading) { Text(item.brand)
                    Text(item.size)
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                    Text("\(item.price) €")
                        .font(.system(size: 11))
                        .foregroundColor(Color.orange)
                }.padding()
            }
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
