//
//  ShoppingHistoryView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 19.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData



struct ShoppingHistoryView: View {
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using CheckoutNode NSManagedObject class
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    
    var body: some View {
        // Lists items from CheckoutNode core data
        List(checkoutResults, id: \.self) { node in
            HStack {
                VStack {
                    // Item brand name
                    Text(node.brand)
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                    // Item size
                    Text(node.size)
                        .font(.system(size: 11))
                    // Item price
                    Text(node.price)
                        .font(.system(size: 11))
                        .foregroundColor(.orange)
                }
                .padding()
                HStack {
                    Text("Purchase date: ")
                        .fontWeight(.medium)
                    // Date of purchase
                    Text("\(formatingDate)")
                        .fontWeight(.medium)
                }
            }
        }
    }
}
// Functions to get date
func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
}
// Formats date
let formatingDate = getFormattedDate(date: Date(), format: "dd.MM.yy")
       
// For canvas preview
struct ShoppingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHistoryView()
    }
}
