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
    @State private var number : Int = 0
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        VStack {
                            SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                self.numberToOrder(number: node.order)
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
            }//.navigationBarItems(trailing: EditButton())
        }
        .navigationBarTitle(Text("Marketplace"))
    }
    
    // ---------FUNCTIONS--------
    
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("---------")
        print("Current order: \(number)")
    }
    
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
        //lista count
        //order on last +1
        if let lastNumber = (fetchedResults.last?.order) {
            print("last order: \(lastNumber)")
            print("difference of last and 1: \(lastNumber - 1)")
        }
        var arr: [Int] = []
        for i in fetchedResults {
            print("\(String(describing: i.self))")
            arr.append(i.self.order)
            print(arr)
        }
        
        
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



//indexOfOrder =

/*
let firstOrder = fetchedResults.first?.order ?? -1
print("first order: \(firstOrder)")
let difference = firstOrder - 1

print("difference of first and 1: \(difference)")

print("item count: \(fetchedResults.count)")
//---- Difference ----
if difference >= 0 { //--
    //if order number is within index range
    if (fetchedResults.last?.order ?? 0 == fetchedResults.count) {
       let currentOrder = self.number
        let node = fetchedResults[currentOrder]
        managedObjectContext.delete(node)
    }
        //if order number out of index range
    else if (fetchedResults.last?.order ?? 0 > fetchedResults.count) {
        let currentOrder = self.number
        // if first of the orders
        if (currentOrder == firstOrder) {
            let node = fetchedResults[currentOrder]
            managedObjectContext.delete(node)
            print("Deletion safe: currentOrder == firstOrder")
        }
        // if out of index range and not the first index
        else if (currentOrder > firstOrder) {
            let distanceToFirst = currentOrder - firstOrder
            let offsetIndx = currentOrder - distanceToFirst
            let offsetNode = fetchedResults[offsetIndx]
            
            print("current order - first order")
            
            
            //print("Deletion safe: currentOrder > firstOrder")
        }
        // if index 2
        //cur2 - fir1 = dis1
        //fir1(ind1) + (cur2 - dis1) = ind2
        /*
        1 1
        2 6
        3 7 <--
        4 9
        
         cur7 - fir1
         
         
         
         cur7 - fir1 = dis6
         fir1(ind1) + (cur7 - dis6) = ind2
         
         
        */
        let cut = (fetchedResults.last?.order ?? 0) - currentOrder
        let correctedIndex = fetchedResults.count - cut
        let offsetNode = fetchedResults[correctedIndex]
        managedObjectContext.delete(offsetNode)
    }else {
        print("if & else if failed")
    }
} else {
    print("-Cant Delete-")
}
*/



/*
 let node = fetchedResults[self.number]
                print("order number fetched: \(node.order)")
                let countOfOrders = fetchedResults.count
                
                if (fetchedResults.last?.order ?? 1) > self.number {
                    print("--too high order--")
                } else {
                    print("fetchedResults.last?.order ?? 1) > self.number")
                }
                
                if ((countOfOrders - 1) >= 0 && ( fetchedResults.last?.order ?? 1 == self.number)) {
                    print("items remaining: \(countOfOrders - 1)")
                    managedObjectContext.delete(node)
                    print("deleted")
                    saveItems()
                } else if ( fetchedResults.last?.order ?? 1 > self.number) {
                    
                    print("last order higher than clicked order")
                } else if ( fetchedResults.first?.order ?? -1 == self.number) {
                    let offsetNode = fetchedResults[fetchedResults.first?.order ?? 0]
                    managedObjectContext.delete(offsetNode)
                    print("deleted")
                    saveItems()
                    print("last order higher than clicked order")
                }
                    
                else {
                    print("Cant Delete")
                }
                
                print("saved")
 */




