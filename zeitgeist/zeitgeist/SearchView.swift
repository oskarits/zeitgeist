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
    @State var sizes = ["One Size", "32", "34", "36", "38", "40", "42", "44"]
    @State var filterTitle = "Search by size: "
    
    var dropDown: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(filterTitle)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                }.onTapGesture {
                    self.expand.toggle()
                }
                Button(action: {
                    self.searchBy = ""
                    self.filterTitle = "Search by size: "
                }) {
                    Image(systemName: "x.circle.fill").foregroundColor(.black)
                }
            }
            if expand {
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        self.searchBy = size
                        self.filterTitle = "Search by size: " + size
                        self.expand.toggle()
                    }) {
                        Text(size)
                    }
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
