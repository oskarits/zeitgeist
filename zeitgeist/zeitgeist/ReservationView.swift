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
    @ObservedObject var networkingManager = NetworkingManager()
    var notification = Notification()
    @State private var confirmRes = "reservationConfirmed"
    @State private var declineRes = "reservationDeclined"
    @State private var number : Int = 0
    @State private var updater = true
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        NavigationLink(destination:
                            VStack {
                                SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                    self.numberToOrder(number: node.order)
                                    
                                }
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("BRAND: ")
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
                                        Text("PRICE: ")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                        Text("\(node.price) €")
                                            .font(.system(size: 18))
                                    }
                                    Text("Reservation request by:\n \(self.isLoggedInResults[0].idString)")
                                        .font(.system(size: 18))
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                }
                                if node.isReserved {
                                HStack {
                                    Button(action: {
                                        self.notification.SendNotification(title: self.confirmRes, body: "pickupText")
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
                                        
                                        self.notification.SendNotification(title: self.declineRes, body: "sorryText")
                                        
                                        self.numberToOrder(number: node.order)
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
                            HStack {
                                ReservationListImage(url: "\(self.url)" + "\(node.image)")
                                VStack(alignment: .leading) {
                                    Text("\(node.brand)")
                                        .fontWeight(.medium)
                                    HStack {
                                        Text("sizeText")
                                            .font(.system(size: 11))
                                        Text("\(node.size)")
                                            .font(.system(size: 11))
                                    }
                                    Text("\(node.price) €")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.orange)
                                        .fontWeight(.regular)
                                }
                                if node.isCollected {
                                    Text("Collected")
                                        .padding(10)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .background(Color.green)
                                        .cornerRadius(18)
                                }
                                if !node.isCollected {
                                    Text("Pending collection")
                                        .padding(10)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.white)
                                        .background(Color.gray)
                                        .opacity(0.5)
                                        .cornerRadius(18)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("reservedItemsTitle"), displayMode: .inline)
    }
    
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("---------")
        print("Current order: \(number)")
        
    }
    
    func updateItemNode(node: ItemNode) {
        let isCollected = true
        let node = node
        node.isCollected = isCollected
        node.isReserved = false
        managedObjectContext.performAndWait {
            try? managedObjectContext.save()
        }
    }
    
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
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
//        self.updater.toggle()
    }
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
            if filterIndex.count > 0 {
                saveItems()
                print("list saved")
            }
        } else {
            print("optional fail")}
    }
}




struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
