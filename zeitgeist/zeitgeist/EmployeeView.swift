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
                    Text("Welcome to the employee view.")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Check current reservations and scan the customer's Wardrobe code")
                        .font(.title)
                        .padding()
                    NavigationLink(destination: ReservationView()) {
                        VStack {
                            Text("showReservationsText")
                                .fontWeight(.bold)
                            Text("(\(fetchedResults.count))")
                        }
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .border(Color.black, width: 2)
                            .frame(width: 300, height: 300)
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
