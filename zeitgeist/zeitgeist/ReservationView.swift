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
    @State private var confirmRes = "Your reservation has been confirmed :)"
    @State private var declineRes = "Your reservation has been declined :("
    
    @State private var number : Int = 0
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
//    var body: some View {
//        VStack {
//            NavigationView {
//                List {
//                    self.ReservedItems
//                }
//            }
//        }.navigationBarTitle(Text("Reserved Items"), displayMode: .inline)
//    }
    
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
                                Text("SIZE: \(node.size)").font(.system(size: 11))
                                Text("\(node.price) €").font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.regular)
                                HStack {
                                    Button(action: {self.notification.SendNotification(title: self.confirmRes, body: "Please pickup :)")}) {
//                                        Image(systemName: "checkmark")
                                        Text("Accept")}
                                            .background(Color.green)
                                            .padding()
                                            .foregroundColor(Color.white)
                                            .cornerRadius(10)
                                    Button(action: {self.notification.SendNotification(title: self.declineRes, body: "We're sorry about that :(")}) {
//                                        Image(systemName: "trash")
                                        Text("Decline")}
                                            .foregroundColor(Color.white)
                                            .padding()
                                            .background(Color.red)
                                            .cornerRadius(10)
                                }.padding()
                                    .font(.title)
                        }) {
                            VStack {
                                Text("\(node.brand)").fontWeight(.medium)
                                Text("SIZE: \(node.size)").font(.system(size: 11))
                                Text("\(node.price) €").font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                                    .fontWeight(.regular)
                                
                            }
                        }
                    }
        //            .onDelete(perform: deleteItems)
                }
            }
        }.navigationBarTitle(Text("Reserved Items (Employee)"), displayMode: .inline)
        
        // TODO replace with a list of the reserved items
//        ForEach(networkingManager.clothingList.items) { item in
//            NavigationLink(destination:
//                VStack(alignment: .leading) {
//                    Text(item.brand).font(.largeTitle)
//                    Text(item.size)
//                    Text(item.condition)
//                    Text(item.description)
//                    Text("\(item.price) €")
//                        .font(.system(size: 20))
//                        .foregroundColor(Color.orange)
//                    // TODO Remove item from list after it has been accepted or declined
//                    HStack {
//                        Button(action: {self.notification.SendNotification(title: self.confirmRes, body: "Please pickup :)")}) {
//                            Image(systemName: "checkmark")
//                            Text("Accept")}.foregroundColor(.green).padding()
//                        Button(action: {self.notification.SendNotification(title: self.declineRes, body: "We're sorry about that :(")}) {
//                            Image(systemName: "trash")
//                            Text("Decline")}.foregroundColor(.red).padding()
//                    }.padding()
//                        .font(.title)
//
//            }) {

//                VStack(alignment: .leading) { Text(item.brand)
//                    Text(item.size)
//                        .font(.system(size: 11))
//                        .foregroundColor(Color.gray)
//                    Text("\(item.price) €")
//                        .font(.system(size: 11))
//                        .foregroundColor(Color.orange)
//                }.padding()
//            }
//        }
    }
    
    func numberToOrder(number: Int) {
               self.number = (number - 1)
               print("---------")
               print("Current order: \(number)")
           }

    
}


struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
