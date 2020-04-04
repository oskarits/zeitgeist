//
//  DataView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 25.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData


struct DataView: View {

    @ObservedObject var networkingManager = NetworkingManager()
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        Text("\(node.idString)")

                        /*
                        VStack(alignment: .leading) {
                            
                            ImageView(item: item)
                            
                            Text(item.brand)
                            Text("SIZE: \(item.size)")
                            Text("\(item.price) €")
                        }
                        */
                        
                    }
                .onDelete(perform: deleteItems)
                }
            }.navigationBarItems(trailing: EditButton())
        }
        .navigationBarTitle(Text("Marketplace"))
    }
    
    // ---------FUNCTIONS--------
    
    
    func addItem(itemID: String) {
        let node = ItemNode(context: managedObjectContext)
        node.idString = itemID
        saveItems()
    }
    
    func deleteItems(indexSet: IndexSet) {
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems()
        
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    
    
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
