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
    var notification = Notification()
    @State private var confirmRes = "Your reservation has been confirmed :)"
    @State private var declineRes = "Your reservation has been declined :("
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    self.ReservedItems
                }
            }
        }.navigationBarTitle(Text("Reserved Items"), displayMode: .inline)
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
                    // TODO Remove item from list after it has been accepted or declined
                    HStack {
                        Button(action: {self.notification.SendNotification(title: self.confirmRes, body: "Please pickup :)")}) {
                            Image(systemName: "checkmark")
                            Text("Accept")}.foregroundColor(.green).padding()
                        Button(action: {self.notification.SendNotification(title: self.declineRes, body: "We're sorry about that :(")}) {
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
