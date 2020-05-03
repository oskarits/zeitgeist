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
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    
    
    var body: some View {
        List(checkoutResults, id: \.self) { node in
            HStack {
                VStack {
                    Text(node.brand)
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                    Text(node.size)
                        .font(.system(size: 11))
                    Text(node.price)
                        .font(.system(size: 11))
                        .foregroundColor(.orange)
                }
                .padding()
                HStack {
                    Text("Purchase date: ")
                        .fontWeight(.medium)
                    Text("\(formatingDate)")
                        .fontWeight(.medium)
                }
            }
        }
    }
}

func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
}

let formatingDate = getFormattedDate(date: Date(), format: "dd.MM.yy")
       

struct ShoppingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHistoryView()
    }
}
