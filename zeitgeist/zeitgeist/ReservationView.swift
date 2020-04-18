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
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        NavigationLink(destination:
                            VStack {
                                SearchImageViewComponent(url: "\(self.url)" + "\(node.image)").onTapGesture {
                                    self.numberToOrder(number: node.order)
            //                        self.deleteCore()
                                    
                                }
                                Text("\(node.brand)").fontWeight(.medium)
                                Text("sizeText \(node.size)").font(.system(size: 11))
                                Text("\(node.price) €").font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.regular)
                                HStack {
                                    Button(action: {self.notification.SendNotification(title: self.confirmRes, body: "pickupText")
                                        self.updateItemNode(node: node)
                                    }) {
//                                        Image(systemName: "checkmark")
                                        Text("acceptText")}
                                            .background(Color.green)
                                            .padding()
                                            .foregroundColor(Color.white)
                                            .cornerRadius(10)
                                    Button(action: {self.notification.SendNotification(title: self.declineRes, body: "sorryText")}) {
//                                        Image(systemName: "trash")
                                        Text("declineText")}
                                            .foregroundColor(Color.white)
                                            .padding()
                                            .background(Color.red)
                                            .cornerRadius(10)
                                }.padding()
                                    .font(.title)
                        }) {
                            VStack {
                                Text("\(node.brand)").fontWeight(.medium)
                                Text("sizeText \(node.size)").font(.system(size: 11))
                                Text("\(node.price) €").font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.regular)
                                
                            }
                        }
                    }
        //            .onDelete(perform: deleteItems)
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
        managedObjectContext.performAndWait {
    try? managedObjectContext.save()
            }
        }
}




struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
