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
    
    @State var expand = false
    @State var searchBy = ""
    
    var dropDown: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Search by size: ")
                Image(systemName: expand ? "chevron.up" : "chevron.down")
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                Button(action: {
                    self.searchBy = "one"
                    self.expand.toggle()
                }) {
                    Text("One size")
                }
                Button(action: {
                    self.searchBy = "32"
                    self.expand.toggle()
                }) {
                    Text("32")
                }
                Button(action: {
                    self.searchBy = "34"
                    self.expand.toggle()
                }) {
                    Text("34")
                }
                Button(action: {
                    self.searchBy = "36"
                    self.expand.toggle()
                }) {
                    Text("36")
                }
                
//                Button(action: {
//                    self.searchBy = "userSize"
//                    self.expand.toggle()
//                }) {
//                    Text("Your size")
//                }
//                Button(action: {
//                    self.searchBy = "price"
//                    self.expand.toggle()
//                }) {
//                    Text("Price €")
//                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText, placeholder: "searchItemsText")
                    self.dropDown
                    List {
                        ForEach(networkingManager.clothingList.items) { item in
                            //self.searchBy
                            if (self.searchBy.count > 0) {
                                if (item.size.contains(self.searchBy)) {
                                    SearchNavigation(item: item)
                                }
                            }
                            if (self.searchText.isEmpty && self.searchBy.count == 0) {
                                SearchNavigation(item: item)
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBy.count == 0) {
                                SearchNavigation(item: item)
                            }
                        }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
                    // Navigates to reservation list
                    .navigationBarItems( trailing:
                        NavigationLink(destination: QrView()) {
                            Image(systemName: "barcode").font(Font.system(size: 30, weight: .regular))
                        }
                )
                    .navigationBarTitle(Text("Search Items"), displayMode: .inline)
            }
        }.resignKeyboardOnDragGesture()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
