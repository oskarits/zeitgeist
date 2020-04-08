//
//  ItemNodeView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 4.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData

struct ItemNodeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    //---
    @ObservedObject var shoppingHistory = ShoppingHistory()
    @ObservedObject var networkingManager = NetworkingManager()
    @State private var searchText : String = ""
    @State private var itemCart : [String] = []
    @State private var showPopover: Bool = false
    @State private var showToast = false
    @State private var selectedItem : String = ""
    @State private var shoppingCartTitleText : String = "Shopping cart"
    @State private var shoppingList: [(key: String, value: String)] = [:].sorted{$0.value < $1.value}
    //---
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(isLoggedInResults, id: \.self) { node in
                        HStack {
                            
                            VStack {
                                if (node.isLoggedIn) {
                                    Text("\(node.idString)")
                                    Text("Logged in")
                                }
                                if (node.isLoggedIn == false) {
                                    Text("Usernae: \(node.idString)")
                                    Text("Not logged in")
                                }
                                Button(action: {
                                    self.isTrue(node: node)
                                }) {
                                    Text("Change signed in state")
                                }
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                }
                Button(action: {
                    self.isFalse()
                }) {
                    Text("add false")
                }
                
                
                
                
            }.navigationBarItems(trailing: EditButton())
                .navigationBarTitle(Text("Reservations"), displayMode: .inline)
        }
        
    }
    
    // ---------FUNCTIONS--------
    
    //Adds item listing to CoreData
    func isFalse() {
        let node = LoginNode(context: managedObjectContext)
        node.isLoggedIn = false
        saveItems()
    }
    
    func isTrue(node: LoginNode) {
        let isTrue = true
        let isFalse = false
        let node = node
        if node.isLoggedIn == false {
            node.isLoggedIn = isTrue
        } else if (node.isLoggedIn) {
            node.isLoggedIn = isFalse
        }
        managedObjectContext.performAndWait {
    try? managedObjectContext.save()
            }
        }
    
    
    func deleteItems(indexSet: IndexSet) {
        let node = isLoggedInResults[indexSet.first!]
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
