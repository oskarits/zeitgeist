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
                                Text("\(node.idString)").fontWeight(.medium)
                            }
                            VStack {
                                if (node.isLoggedIn) {
                                    Text("Logged in")
                                }
                                if (node.isLoggedIn == false) {
                                    Text("Not logged in")
                                }
                                
                                
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Button(action: {
                    self.addItem()
                }) {
                    Text("add false")
                }
            }.navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Reservations"), displayMode: .inline)
        }
        
    }

    // ---------FUNCTIONS--------
    
    //Adds item listing to CoreData
    func addItem() {
        let node = LoginNode(context: managedObjectContext)
        node.isLoggedIn = false
        saveItems()
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
