//
//  SearchFilters.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
import WaterfallGrid

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
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)
    // Binding value for string value of searched size used in Text()
    @Binding var sizeFilterTitle : String
    // Binding value for string value of searched price used in Text()
    @Binding var priceFilterTitle : String
    
    var body: some View {
        VStack {
            if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                VStack {
                    WaterfallGrid(self.networkingManager.clothingList.items) {item in
                        VStack {
                            ImageView(item: item)
                            SearchNavigation(item: item)
                        }.padding()
                    }
                }
            }// if empty
            if (self.searchText.isEmpty == false || self.searchBySize.count > 0 || self.searchByPrice.count > 0) {
                List {
                    ForEach(networkingManager.clothingList.items) { item in
                        
                        if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
                            
                            if (self.searchText.isEmpty) {
                                if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                if (self.searchBySize == "Your size") {
                                    if (self.isLoggedInResults.endIndex > 0) {
                                        if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                            VStack {
                                                FilteredItemImageView(item: item)
                                                SearchNavigation(item: item)
                                            }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                        }
                                    }
                                }
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize != "Your size") {
                                if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size") {
                                if (self.isLoggedInResults.endIndex > 0) {
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        VStack {
                                            FilteredItemImageView(item: item)
                                            SearchNavigation(item: item)
                                        }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                    }
                                }
                            }
                        }
                        if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size" && self.searchByPrice.count < 1) {
                            if (self.isLoggedInResults.endIndex > 0) {
                                if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                        }
                        if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
                            if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                if (self.searchText.isEmpty) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                                if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                                    VStack {
                                        FilteredItemImageView(item: item)
                                        SearchNavigation(item: item)
                                    }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                }
                            }
                            if (self.searchBySize == "Your size" && self.searchText.isEmpty) {
                                if (self.isLoggedInResults.endIndex > 0) {
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        VStack {
                                            FilteredItemImageView(item: item)
                                            SearchNavigation(item: item)
                                        }.frame(minWidth: 300, maxWidth: 375, minHeight: 400, maxHeight: 500)
                                    }
                                }
                            }
                        }
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

