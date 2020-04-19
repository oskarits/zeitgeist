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
            VStack {
                Text(node.brand)
                Text(node.size)
                Text(node.price)
            }
        }
    }
}

struct ShoppingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHistoryView()
    }
}
