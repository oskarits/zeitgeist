//
//  SearchView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @ObservedObject var shoppingHistory = ShoppingHistory()
    @ObservedObject var networkingManager = NetworkingManager()
    @State private var searchText : String = ""
    
    @State private var itemCart : [String] = []
    
    @State private var showPopover: Bool = false
    @State private var showToast = false
    
    @State private var selectedItem : String = ""
    @State private var shoppingCartTitleText : String = "Shopping cart"
    @State private var shoppingList: [(key: String, value: String)] = [:].sorted{$0.value < $1.value}
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
    
    var searchNavigation: some View {
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
                                Image(systemName: "cart.fill").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartMinus(index: "\(item.id)")
                                    //self.addItem(itemID: "\(item.id)")
                                }
                            }
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {
                                Image(systemName: "cart.badge.plus").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartPlus(key: item.brand, value: "\(item.id)")
                                    self.addItem(itemID: "\(item.id)", brand: item.brand, size: item.size, price: item.price, image: "\(item.images[0])")
                                }
                            }
                        }
                    }
                }
            }
            if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                NavigationLink(destination:
                SingleItemView(item: item)) {
                    VStack(alignment: .leading) {
                        HStack {
                            ListItem(item: item)
                            Spacer()
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) != nil) {
                                Image(systemName: "cart.fill").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartMinus(index: "\(item.id)")
                                    //self.addItem(itemID: "\(item.id)")
                                }
                            }
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {
                                Image(systemName: "cart.badge.plus").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartPlus(key: item.brand, value: "\(item.id)")
                                    self.addItem(itemID: "\(item.id)", brand: item.brand, size: item.size, price: item.price, image: "\(item.images[0])")
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView{
                VStack {
                    SearchBar(text: $searchText, placeholder: "Search items")
                    List {
                        self.searchNavigation
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
            ZStack {
                VStack {
                    Spacer()
                    VStack{
                        VStack {
                            Button(action: {
                                self.showPopover.toggle()
                                UIApplication.shared.endEditing(true)
                            }) {
                                Image(systemName: "return")
                                    .font(Font.system(size: 30, weight: .regular))
                            }.padding(20)
                            ReservationList()
                        }
                    }
                }
            }.background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .offset(x:0, y: self.showPopover ? 0 : UIApplication.shared.keyWindow?.frame.height ?? 0)
        }.resignKeyboardOnDragGesture()
    }
    // ---------FUNCTIONS--------
    
    
    func addItem(itemID: String, brand: String, size: String, price: String, image: String) {
        let node = ItemNode(context: managedObjectContext)
        node.idString = itemID
        node.size = size
        node.brand = brand
        node.size = size
        node.price = price
        node.image = image
        node.order = (fetchedResults.last?.order ?? 0) + 1  //-----
        print("order: \(node.order)")
        saveItems()
    }

    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    
    func ShoppingCartPlus(key: String, value: String) {
        self.itemCart.append(key)
        self.showToast.toggle()
        self.shoppingList.insert((key: key, value: value), at: self.shoppingList.count)
        self.selectedItem = key
        UIApplication.shared.endEditing(true)
    }
    
    func PopOverToggle() {
        self.showPopover.toggle()
        UIApplication.shared.endEditing(true)
    }
    
    func ShoppingCartMinus(index: String) {
        if self.shoppingList.count > 0 {
            let indx = self.shoppingList.firstIndex(where: {$0.value == index})
            print(indx ?? "nothing")
            if indx != nil {
                self.shoppingList.remove(at: indx ?? 0)
            }
        }
        UIApplication.shared.endEditing(true)

    }
    

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
