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

// For employees only
struct EmployeeView: View {
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack { // Employee greeting
                        Text("welcomeText")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.orange)
                        Text("welcomeText2")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                    // Employee instruction
                    Text("employeeBody")
                        .font(.title)
                        .padding()
                    // Navigation link to ReservationView()
                    NavigationLink(destination: ReservationView()) {
                        VStack {
                            Text("showReservationsText")
                                .fontWeight(.bold)
                            // Show the amount of reservations
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
                    // Navigation link to QR scanner
                    NavigationLink(destination: QrView()) {
                        Image(systemName: "barcode").font(Font.system(size: 30, weight: .regular))
                    }
                )
            }
        }
    }
}

// For canvas preview
struct EployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView()
    }
}
