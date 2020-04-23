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
                    Text("Welcome to the employee view. Here You can view current reservations and scan the customer's wardrobe code.")
                        .font(.headline)
                        .padding()
                    NavigationLink(destination: ReservationView()) {
                        VStack {
                            Text("showReservationsText")
                            Text("(\(fetchedResults.count))")
                        }
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .border(Color.black, width: 2)
                            .frame(width: 300, height: 300)
                            .cornerRadius(19)

                                
                        
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
