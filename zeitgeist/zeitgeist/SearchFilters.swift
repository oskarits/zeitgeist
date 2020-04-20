//
//  SearchFilters.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct SearchFilters: View {
    //@ObservedObject var shoppingHistory = ShoppingHistory()
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
    var item :  ClothingListEntry
    
    var body: some View {
//        let wfGrid = WaterfallGrid((networkingManager.clothingList.items), id: \.self) { item in
        let wfGrid = WaterfallGrid((networkingManager.clothingList.items), id: \.self) { item in
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
            return wfGrid
        }
//        List {
//            ForEach(networkingManager.clothingList.items) { item in
//
//                if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
//
//                    if (self.searchText.isEmpty) {
//                        if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                            SearchNavigation(item: item)
//
//                        }
//                        if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
//                            SearchNavigation(item: item)
//                        }
//                    }
//                    if (item.brand.lowercased().contains(self.searchText.lowercased())) {
//                        if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                            SearchNavigation(item: item)
//                        }
//                        if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
//                            SearchNavigation(item: item)
//                        }
//                    }
//                }
//                if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
//                    if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
//                        if (self.searchText.isEmpty) {
//                            SearchNavigation(item: item)
//                        }
//                        if (item.brand.lowercased().contains(self.searchText.lowercased())) {
//                            SearchNavigation(item: item)
//                        }
//                    }
//                }
//                if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
//                    SearchNavigation(item: item)
//                }
//                if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
//                    SearchNavigation(item: item)
//                }
//            }
//        }
//
//    }
}
