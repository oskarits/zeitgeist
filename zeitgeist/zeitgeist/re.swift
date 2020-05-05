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
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // URL for image fetching
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    // Number value to save items to core data with index number
    @State private var number : Int = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                List { // Lists each item in ItemNode core data
                    ForEach(fetchedResults, id: \.self) { node in
                        HStack {
                            VStack {
                                // Displays the image of the fetched item
                                SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                    self.numberToOrder(number: node.order)
                                    self.deleteCore()
                                }
                            }
                            // Item info and styling
                            VStack(alignment: .center) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(node.brand)").fontWeight(.medium)
                                        Text("SIZE: \(node.size)").font(.system(size: 13))
                                        Text("\(node.price) €").font(.system(size: 13))
                                            .foregroundColor(Color.orange)
                                            .fontWeight(.regular)
                                    }.padding(.bottom)
                                    Spacer()
                                }
                                VStack(alignment: .leading) {
                                    // If item is collected
                                    if (node.isCollected) {
                                        HStack {
                                            Text("Collected")
                                                .padding(10)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                                .background(Color.green)
                                                .cornerRadius(18)
                                            Spacer()
                                        }
                                    }
                                    // If item is collected
                                    if (node.isCollected == false) {
                                        HStack{
                                            Text("Pending collection")
                                                .padding(10)
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.black)
                                                .background(Color.gray)
                                                .opacity(0.5)
                                                .cornerRadius(18)
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }.padding()
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }.navigationBarItems(trailing: EditButton())
                .navigationBarTitle(Text("reservationListTitle"), displayMode: .inline)
        }
    }
    // Places item index number to variable
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("Current order: \(number)")
    }
    // Function for adding item to core data
    func addItem(itemID: String) {
        let node = ItemNode(context: managedObjectContext)
        node.idString = itemID
        saveItems()
    }
    // Deletes item from core data
    func deleteItems(indexSet: IndexSet) {
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems()
    }
    
    // Programmatically deletes item from core data
    func deleteCore() {
        let currentOrderString: String = String(self.number + 1)
        var orderArray = ["empty"]
        for i in fetchedResults {
            orderArray.append("\(i.self.order)")
        }
        let filterIndex = orderArray.enumerated().filter { $0.element == currentOrderString }.map { $0.offset }
        if (fetchedResults.count == (orderArray.count - 1) && filterIndex.count > 0) {
            let nodeIndexInt = filterIndex.compactMap { $0 }
            let orderIndex : Int = nodeIndexInt[0] - 1
            let nodeIndex: Int = orderIndex
            print(nodeIndex)
            let node = fetchedResults[nodeIndex]
            managedObjectContext.delete(node)
            print("item deleted")
            saveItems()
        } else {
            print("optional fail")}
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
            print("saved")
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
