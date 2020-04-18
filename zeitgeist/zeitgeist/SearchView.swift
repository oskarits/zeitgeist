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
    
    var dropDown: some View {
        VStack(spacing: 30) {
            HStack {
                Text("text1")
                Image(systemName: expand ? "chevron.up" : "chevron.down")
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                Button(action: {
                    print("333")
                    self.expand.toggle()
                }) {
                    Text("aaa")
                }
                Button(action: {
                    print("222")
                    self.expand.toggle()
                }) {
                    Text("bbb")
                }
                Button(action: {
                    print("111")
                    self.expand.toggle()
                }) {
                    Text("bbb")
                }
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
                            if (self.searchText.isEmpty) {
                                SearchNavigation(item: item)
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased())) {
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
