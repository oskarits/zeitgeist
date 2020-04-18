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
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)
    @State var sizeFilterTitle = "Size: "
    @State var priceFilterTitle = "Price: "
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText, placeholder: "searchItemsText")
                    VStack {
                        HStack {
                            Spacer()
                            Text("Search by: ")
                            Spacer()
                            SizeFilter(searchBySize: $searchBySize, sizeFilterTitle: $sizeFilterTitle, expand: $expand, sizes: sizes)
                            Spacer()
                            PriceFilter(searchByPrice: $searchByPrice, priceFilterTitle: $priceFilterTitle, expand2: $expand2, prices: prices)
                            Spacer()
                        }
                    }
                    List {
                        ForEach(networkingManager.clothingList.items) { item in
                            Aaa(item: item, searchText: self.$searchText, expand: self.$expand, expand2: self.$expand2, searchBySize: self.$searchBySize, searchByPrice: self.$searchByPrice, sizeFilterTitle: self.$sizeFilterTitle, priceFilterTitle: self.$priceFilterTitle)
//                            if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
//
//                                if (self.searchText.isEmpty) {
//                                    if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                                        SearchNavigation(item: item)
//
//                                    }
//                                    if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
//                                        SearchNavigation(item: item)
//                                    }
//                                }
//                                if (item.brand.lowercased().contains(self.searchText.lowercased())) {
//                                    if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                                        SearchNavigation(item: item)
//                                    }
//                                    if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
//                                        SearchNavigation(item: item)
//                                    }
//                                }
//                            }
//                            if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
//                                if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                                    if (self.searchText.isEmpty) {
//                                        SearchNavigation(item: item)
//                                    }
//                                    if (item.brand.lowercased().contains(self.searchText.lowercased())) {
//                                        SearchNavigation(item: item)
//                                    }
//                                }
//                            }
//                            if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
//                                SearchNavigation(item: item)
//                            }
//                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
//                                SearchNavigation(item: item)
//                            }
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
struct Aaa: View {
    var item : ClothingListEntry
    @ObservedObject var shoppingHistory = ShoppingHistory()
    @ObservedObject var networkingManager = NetworkingManager()
    @Binding var searchText : String
    @Binding var expand : Bool
    @Binding var expand2 : Bool
    @Binding var searchBySize : String
    @Binding var searchByPrice : String
    @State var sizes = ["One Size", "32", "34", "36", "38", "40", "42", "44"]
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)
    @Binding var sizeFilterTitle : String
    @Binding var priceFilterTitle : String

    var body: some View {

        VStack {
            if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
                
                if (self.searchText.isEmpty) {
                    if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                        SearchNavigation(item: item)
                        
                    }
                    if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                        SearchNavigation(item: item)
                    }
                }
                if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                    if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                        SearchNavigation(item: item)
                    }
                    if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                        SearchNavigation(item: item)
                    }
                }
            }
            if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
                if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
                    if (self.searchText.isEmpty) {
                        SearchNavigation(item: item)
                    }
                    if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                        SearchNavigation(item: item)
                    }
                }
            }
            if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                SearchNavigation(item: item)
            }
            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                SearchNavigation(item: item)
            }
        }
        
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

/*
 Aaa(item: item, searchText: self.$searchText, expand: self.$expand, expand2: self.$expand2, searchBySize: self.$searchBySize, searchByPrice: self.$searchByPrice, sizeFilterTitle: self.$sizeFilterTitle, priceFilterTitle: self.$priceFilterTitle)
 */
