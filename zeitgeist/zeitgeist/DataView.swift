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
                            SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                self.deleteCore(/*order: node.order*/)
                            }
                            Text("\(node.brand)").fontWeight(.medium)
                            Text("SIZE: \(node.size)").font(.system(size: 11))
                            Text("\(node.price) €").font(.system(size: 11))
                                .foregroundColor(Color.orange)
                                .fontWeight(.regular)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItem)
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
    
    func deleteCore(/*order: Int*/) {
        print("------")
        //let index = (order)
        //print("index = order: \(index)")
        let node = fetchedResults[0]
        //print("delete: \(node)")
        print("node.order: \(node.order)")
        let count = fetchedResults.count
        print(count)
        managedObjectContext.delete(node)
        print("deleted")
        saveItems()
        print("saved")
    }
    
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    func moveItem(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        
        if source < destination {
            var startIndex = source + 1
            let endIndex = destination - 1
            var startOrder = fetchedResults[source].order
            while startIndex <= endIndex {
                fetchedResults[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            
            fetchedResults[source].order = startOrder
            
        } else if destination < source {
            var startIndex = destination
            let endIndex = source - 1
            var startOrder = fetchedResults[destination].order + 1
            let newOrder = fetchedResults[destination].order
            while startIndex <= endIndex {
                fetchedResults[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            fetchedResults[source].order = newOrder
        }
        
        saveItems()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
