//
//  ReservationList.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 4.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct ReservationList: View {
    
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
                        HStack {
                            VStack {
                                SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                    self.numberToOrder(number: node.order)
                                    self.deleteCore()
                                    
                                }
                                Text("\(node.brand)").fontWeight(.medium)
                                Text("SIZE: \(node.size)").font(.system(size: 11))
                                Text("\(node.price) €").font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.regular)
                            }
                            VStack {
                                if (node.isReserved) {
                                    Text("Reserved")
                                }
                                if (node.isReserved == false) {
                                    Text("Not reserved")
                                }
                                if (node.isCollected) {
                                    Text("Collected")
                                }
                                if (node.isCollected == false) {
                                    Text("Not Collected")
                                }
                                
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }.navigationBarItems(trailing: EditButton())
                .navigationBarTitle(Text("reservationListTitle"), displayMode: .inline)
        }
        
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
    
    // Programmatically deletes item
    func deleteCore() {
        let currentOrderString: String = String(self.number + 1)
        var orderArray = ["empty"]
        for i in fetchedResults {
            orderArray.append("\(i.self.order)")
        }
        let filterIndex = orderArray.enumerated().filter { $0.element == currentOrderString }.map { $0.offset }
        print("all orders ", orderArray)
        print("index of the selected order: ", filterIndex)
        if (fetchedResults.count == (orderArray.count - 1) && filterIndex.count > 0) {
            let nodeIndexInt = filterIndex.compactMap { $0 }
            let orderIndex : Int = nodeIndexInt[0] - 1
            let nodeIndex: Int = orderIndex
            print(nodeIndex)
            let node = fetchedResults[nodeIndex]
            managedObjectContext.delete(node)
            print("item deleted")
            saveItems()
            print("list saved")
        } else {
            print("optional fail")}
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ReservationList_Previews: PreviewProvider {
    static var previews: some View {
        ReservationList()
    }
}
