//
//  ReservationView.swift
//  zeitgeist
//
//  Created by Oskari Sieranen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct ReservationView: View {
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // Variable for notification call function
    var notification = Notification()
    // Variable for notification(comfirmed reservation)
    @State private var confirmRes = "reservationConfirmed"
    // Variable for notification(declined reservation)
    @State private var declineRes = "reservationDeclined"
    // Number value to save items to core data with index number
    @State private var number : Int = 0
    // Toggle value for updating view
    @State private var updater = true
    // URL for image fetching
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches core data using CheckoutNode NSManagedObject class
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    
    var body: some View {
        VStack {
            NavigationView {
                List { // Lists each item in ItemNode core data
                    ForEach(fetchedResults, id: \.self) { node in
                        NavigationLink(destination:
                            VStack {
                                // Displays the image of the fetched item
                                SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                    self.numberToOrder(number: node.order)
                                }
                                // Item info and styling
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("brandText")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                        Text("\(node.brand)")
                                            .font(.system(size: 18))
                                    }
                                    HStack {
                                        Text("sizeText")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                        Text("\(node.size)")
                                            .font(.system(size: 18))
                                    }
                                    HStack {
                                        Text("priceText")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                        Text("\(node.price) €")
                                            .font(.system(size: 18))
                                    }
                                    HStack {
                                        Text("requestText")
                                            .font(.system(size: 18))
                                           .fontWeight(.light)
                                           .foregroundColor(Color.gray)
                                        Text("\(self.isLoggedInResults[0].idString)")
                                            .font(.system(size: 18))
                                           .fontWeight(.light)
                                           .foregroundColor(Color.gray)
                                    }
                                       
                                }
                                // If item is reserved
                                if node.isReserved {
                                    HStack {
                                        Button(action: {
                                            // Sends notification item is collected
                                            self.notification.SendNotification(title: self.confirmRes, body: "pickupText")
                                            // Updates core data that item is collected
                                            self.updateItemNode(node: node)
                                        }) {
                                            Image(systemName: "checkmark")
                                            Text("acceptText")
                                        }
                                        .foregroundColor(Color.white)
                                        .padding(12)
                                        .background(Color.green)
                                        .cornerRadius(30)
                                        Button(action: {
                                            // Send notification item is declined
                                            self.notification.SendNotification(title: self.declineRes, body: "sorryText")
                                            // Places item index number to variable
                                            self.numberToOrder(number: node.order)
                                            // Deletes item from core data
                                            self.deleteCore()
                                        }) {
                                            Image(systemName: "xmark")
                                            Text("declineText")
                                        }
                                        .foregroundColor(Color.white)
                                        .padding(12)
                                        .background(Color.red)
                                        .cornerRadius(30)
                                    }
                                    .padding()
                                    .font(.title)
                                }
                        }) {
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        VStack(alignment: .leading) {
                                            // Displays the image of the fetched item
                                            ReservationListImage(url: "\(self.url)" + "\(node.image)")
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        // Item info and styling
                                        VStack(alignment: .leading) {
                                            Text("\(node.brand)")
                                                .fontWeight(.medium)
                                            HStack {
                                                Text("sizeText")
                                                    .font(.system(size: 13))
                                                Text("\(node.size)")
                                                    .font(.system(size: 13))
                                            }
                                            Text("\(node.price) €")
                                                .font(.system(size: 13))
                                                .foregroundColor(Color.orange)
                                                .fontWeight(.medium)
                                        }.padding(.bottom)
                                        // Items collected status
                                        VStack(alignment: .leading) {
                                            // Item is collected
                                            if node.isCollected {
                                                HStack {
                                                    Text("readyCollection")
                                                        .padding(10)
                                                        .font(.system(size: 14))
                                                        .foregroundColor(.white)
                                                        .background(Color.green)
                                                        .cornerRadius(18)
                                                    Spacer()
                                                }
                                            }
                                            // Item is not collected
                                            if !node.isCollected {
                                                HStack{
                                                    Text("pendingCollection")
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
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("reservedItemsTitle"), displayMode: .inline)
    }
    // Places item index number to variable
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("Current order: \(number)")
    }
    // Updates core data that item is collected
    func updateItemNode(node: ItemNode) {
        let isCollected = true
        let node = node
        node.isCollected = isCollected
        node.isReserved = false
        managedObjectContext.performAndWait {
            try? managedObjectContext.save()
        }
    }
    // Function for adding item to core data
    func addItem(itemID: String, brand: String, size: String, price: String) {
        let node = CheckoutNode(context: managedObjectContext)
        node.idString = itemID
        node.size = size
        node.brand = brand
        node.size = size
        node.price = price
        node.isCollected = true
        node.isReserved = true
        node.order = (checkoutResults.last?.order ?? 0) + 1
        print("Order of new item: \(node.order)")
        saveItems()
    }
    // Function to save NSManagedObject to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
            print("saved")
        } catch {
            print(error)
        }
    }
    // Deletes item from core data
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
            if filterIndex.count > 0 {
                saveItems()
            }
        } else {
            print("optional fail")}
    }
}

