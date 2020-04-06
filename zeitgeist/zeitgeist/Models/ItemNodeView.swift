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
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
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
        VStack {
            VStack {
                        List {
                            ForEach(fetchedResults, id: \.self) { node in
                                Text("\(node.idString)")
                                //Text("\(node.id)")
                                //Text("\(node.id)")
                            }
                        .onDelete(perform: deleteItems)
                        }
            //            Button(action: addItem) {
            //                Text("add item")
            //            }
                    }
                    .navigationBarItems(trailing: EditButton())
            NavigationView{
                VStack {
                    SearchBar(text: $searchText, placeholder: "Search items")
                    List {
                        self.itemList
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
                    .navigationBarItems( trailing:
                        Button(action: {
                            self.showPopover.toggle()
                            UIApplication.shared.endEditing(true)
                        }) {
                            Image(systemName: "cart.fill")
                                .font(Font.system(size: 30, weight: .regular))
                        }
                )
                    .navigationBarTitle(Text("Search Items"))
            }.toast(show: $showToast, text: selectedItem)
        }
    }
    
    var itemList: some View {
       
        ForEach(networkingManager.clothingList.items) { item in
            if (self.searchText.isEmpty) {
                NavigationLink(destination:
                SingleItemView(item: item)) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                VStack {
                                    ListItem(item: item)
                                }
                            }
                            
                            Spacer()
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) != nil) {
                                Image(systemName: "cart.fill.badge.minus").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    //self.ShoppingCartMinus(index: "\(item.id)")
                                    self.addItem(itemID: "\(item.id)")
                                }
                            }
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {
                                Image(systemName: "cart.badge.plus").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.addItem(itemID: "\(item.id)")
                                    //self.ShoppingCartPlus(key: item.brand, value: "\(item.id)")

                                }
                            }
                        }
                    }
                }
            }

        }
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
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    
    
}

struct ItemNodeView_Previews: PreviewProvider {
    static var previews: some View {
        ItemNodeView()
    }
}
