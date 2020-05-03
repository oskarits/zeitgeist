//
//  EmployeeView.swift
//  zeitgeist
//
//  Created by Oskari Sieranen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct EmployeeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        Text("Welcome ")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.orange)
                        Text("to the employee view.")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                    Text("Check current reservations and scan the customer's Wardrobe code")
                        .font(.title)
                        .padding()
                    NavigationLink(destination: ReservationView()) {
                        VStack {
                            Text("showReservationsText")
                                .fontWeight(.bold)
                            Text("(\(fetchedResults.count))")
                        }
                            .padding()
                            .foregroundColor(Color.white)
                            .font(.title)
                            .background(Color.orange)
                            .cornerRadius(15.0)
                    }
                }
                .multilineTextAlignment(.center)
                .navigationBarTitle(Text("employeeTitle"), displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: QrView()) {
                        Image(systemName: "barcode").font(Font.system(size: 30, weight: .regular))
                    }
                )
            }
        }
    }
}


struct EployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView()
    }
}
