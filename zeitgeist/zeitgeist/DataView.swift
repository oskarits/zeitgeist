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
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        VStack {
                            SearchImageViewComponent(url: "\(self.url)" + "\(node.image)")
                            Text("\(node.brand)").fontWeight(.medium)
                            Text("SIZE: \(node.size)").font(.system(size: 11))
                            Text("\(node.price) €").font(.system(size: 11))
                                .foregroundColor(Color.orange)
                                .fontWeight(.regular)
                            Button(action: self.deleteCore){
                                Text("delete")
                            }
                        }
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
    
    func deleteCore() {
        let node = fetchedResults[0]
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
