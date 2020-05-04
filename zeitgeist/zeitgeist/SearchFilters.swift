//
//  SearchFilters.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
import WaterfallGrid //&& Int(self.searchByPrice.suffix(2)) == 10)

struct SearchFilters: View {
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // Binding value for searchbar
    @Binding var searchText : String
    // Binding value for expanding size filter
    @Binding var expand : Bool
    // Binding value for expanding price filter
    @Binding var expand2 : Bool
    // Binding value for string value of searched size
    @Binding var searchBySize : String
    // Binding value for string value of searched price
    @Binding var searchByPrice : String
    // Selectable sizes to filter
    @State var sizes = ["Your size", "One Size", "32", "34", "36", "38", "40", "42", "44"]
    // Selectable prices to filter
    @State var prices = ["0 - 10", "10 - 20", "20 - 30", "30 - 40", "40 - 50", "50 -60"]
    // Binding value for string value of searched size used in Text()
    @Binding var sizeFilterTitle : String
    // Binding value for string value of searched price used in Text()
    @Binding var priceFilterTitle : String
    
    var body: some View {
        VStack {
            // If no filters are applied
            if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                VStack {
                    // Displays fetched items in a grid
                    WaterfallGrid(self.networkingManager.clothingList.items) {item in
                        VStack {
                            // ImageView separate to bypass a bug in WaterfallGrid
                            ImageView(item: item)
                            SearchNavigation(item: item)
                        }.padding()
                    }
                }
            }
            // If filtered by brand name and by size or price
            if (self.searchText.isEmpty == false || self.searchBySize.count > 0 || self.searchByPrice.count > 0) {
                // Lists items one by one instead of a grid
                List {
                    ForEach(networkingManager.clothingList.items) { item in
                        // Filters items by price 0€-10€, 11€-20€, 21€-30€ etc.
                        if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
                            // Filter by price and not by brand
                            if (self.searchText.isEmpty) {
                                // Filter by price and size but not by brand name
                                if (Int(self.searchByPrice) ?? 0 <= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                // Filter by price but NOT by brand or size
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                // Filter by price and user's size
                                if (self.searchBySize == "Your size") {
                                    // If user is logged in
                                    if (self.isLoggedInResults.endIndex > 0) {
                                        // Filter by user's size
                                        if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                            VStack {
                                                FilteredItemImageView(item: item)
                                                SearchNavigation(item: item)
                                            }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                        }
                                    }
                                }
                            }
                            // Filter by brand name but not by user's size
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize != "Your size") {
                                // Filter by brand name, size and price but not by user's size
                                if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                // Filter by brand name and price but not by size
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                            // Filter by brand name and user's size
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size") {
                                // If logged in
                                if (self.isLoggedInResults.endIndex > 0) {
                                    // Filters by fetched user's size
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        VStack {
                                            FilteredItemImageView(item: item)
                                            SearchNavigation(item: item)
                                        }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                    }
                                }
                            }
                        }
                        // Filter by brand name and user's size but not price
                        if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size" && self.searchByPrice.count < 1) {
                            // If logged in
                            if (self.isLoggedInResults.endIndex > 0) {
                                // Filters by fetched user's size
                                if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                        }
                        // Filters by size but not price
                        if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
                            // Filters by size
                            if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                // if searchbar is empty
                                if (self.searchText.isEmpty) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                // Filters by size and brand name
                                if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                            // Filters by user's size but not by brand name
                            if (self.searchBySize == "Your size" && self.searchText.isEmpty) {
                                // If logged in
                                if (self.isLoggedInResults.endIndex > 0) {
                                    // Filters by user's size
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        VStack {
                                            FilteredItemImageView(item: item)
                                            SearchNavigation(item: item)
                                        }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                    }
                                }
                            }
                        }
                        // Filters by size
                        if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                            VStack {
                                FilteredItemImageView(item: item)
                                SearchNavigation(item: item)
                            }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                        }
                    }
                }
            }
        }// VStack
    }// body
}

