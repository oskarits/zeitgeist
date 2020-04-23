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
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
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
            Text("Reservations:")
                .fontWeight(.bold)
                .font(.title)
            ReservationView()
            Text("Previous purhcases:")
                .fontWeight(.bold)
                .font(.title)
            ShoppingHistoryView()
                
        }.padding()
    }
}

struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo()
    }
}
