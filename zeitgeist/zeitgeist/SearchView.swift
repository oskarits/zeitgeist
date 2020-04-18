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
    @State var expand2 = false
    @State var searchBySize = ""
    @State var searchByPrice = ""
    @State var sizes = ["One Size", "32", "34", "36", "38", "40", "42", "44"]
    @State var prices = stride(from: 5, through: 80, by: 10).map(String.init)
    //(1...10).map(String.init) //65
    @State var sizeFilterTitle = "Search by size: "
    @State var priceFilterTitle = "Search by price: "

    
    var sizeFilter: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(sizeFilterTitle)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                }.onTapGesture {
                    self.expand.toggle()
                }
                Button(action: {
                    self.searchBySize = ""
                    self.sizeFilterTitle = "Search by size: "
                }) {
                    Image(systemName: "x.circle.fill").foregroundColor(.black)
                }
            }
            if expand {
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        self.searchBySize = size
                        self.sizeFilterTitle = "Search by size: " + size
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
                    HStack {
                        self.sizeFilter
                        self.priceFilter
                    }
                    List {
                        ForEach(networkingManager.clothingList.items) { item in
                            //self.searchBy
                            if (Int(self.searchByPrice) == 5) {
                                SearchNavigation(item: item)
                                Text("gggg")
                            }
                            if (self.searchBySize.count > 0) {
                                if (item.size.contains(self.searchBySize)) {
                                    SearchNavigation(item: item)
                                }
                            }
                            if (self.searchText.isEmpty && self.searchBySize.count == 0) {
                                SearchNavigation(item: item)
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0) {
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
    
    var priceFilter: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(priceFilterTitle)
                    Image(systemName: expand2 ? "chevron.up" : "chevron.down")
                }.onTapGesture {
                    self.expand2.toggle()
                }
                Button(action: {
                    self.searchByPrice = ""
                    self.priceFilterTitle = "Search by price: "
                }) {
                    Image(systemName: "x.circle.fill").foregroundColor(.black)
                }
            }
            if expand2 {
                ForEach(prices, id: \.self) { price in
                    Button(action: {
                        self.searchByPrice = price
                        self.priceFilterTitle = "Search by price: " + price
                        self.expand2.toggle()
                    }) {
                        Text(price)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
