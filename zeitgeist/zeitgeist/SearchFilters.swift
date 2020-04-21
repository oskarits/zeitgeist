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
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    @ObservedObject var networkingManager = NetworkingManager()
    @Binding var searchText : String
    @Binding var expand : Bool
    @Binding var expand2 : Bool
    @Binding var searchBySize : String
    @Binding var searchByPrice : String
    @State var sizes = ["Your size", "One Size", "32", "34", "36", "38", "40", "42", "44"]
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)
    @Binding var sizeFilterTitle : String
    @Binding var priceFilterTitle : String
    
    var body: some View {
        VStack {
            
            if (self.searchText.isEmpty && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                VStack {
                    WaterfallGrid(self.networkingManager.clothingList.items) {item in
                        VStack {
                            ImageView(item: item)
                            SearchNavigation(item: item)
                        }
                        
                    }
                }
            }// if empty
            if (self.searchText.isEmpty == false || self.searchBySize.count > 0 || self.searchByPrice.count > 0) {
                List {
                    ForEach(networkingManager.clothingList.items) { item in
                        
                        if (Int(item.price) ?? 99 <= Int(self.searchByPrice) ?? 0 && Int(item.price) ?? 99 >= (Int(self.searchByPrice) ?? 0) - 9) {
                            
                            if (self.searchText.isEmpty) {
                                if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                                if (self.searchBySize == "Your size") {
                                    if (self.isLoggedInResults.endIndex > 0) {
                                        if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                            ImageView(item: item)
                                            SearchNavigation(item: item)
                                        }
                                    }
                                }
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize != "Your size") {
                                if (Int(self.searchByPrice) ?? 0 >= 5 && item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                                if (Int(self.searchByPrice) ?? 0 >= 5 && self.searchBySize.count == 0) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                            }
                            if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size") {
                                if (self.isLoggedInResults.endIndex > 0) {
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        ImageView(item: item)
                                        SearchNavigation(item: item)
                                    }
                                }
                            }
                        }
                        if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize == "Your size" && self.searchByPrice.count < 1) {
                            if (self.isLoggedInResults.endIndex > 0) {
                                if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                            }
                        }
                        if (self.searchBySize.count > 0 && self.searchByPrice.count == 0) {
                            if (item.size.lowercased().contains(self.searchBySize.lowercased())) {
                                if (self.searchText.isEmpty) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                                if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                                    ImageView(item: item)
                                    SearchNavigation(item: item)
                                }
                            }
                            if (self.searchBySize == "Your size" && self.searchText.isEmpty) {
                                if (self.isLoggedInResults.endIndex > 0) {
                                    if (item.size.lowercased().contains(self.isLoggedInResults[0].size)) {
                                        ImageView(item: item)
                                        SearchNavigation(item: item)
                                    }
                                }
                            }
                        }
                        if (item.brand.lowercased().contains(self.searchText.lowercased()) && self.searchBySize.count == 0 && self.searchByPrice.count == 0) {
                            ImageView(item: item)
                            SearchNavigation(item: item)
                        }
                    }
                }
            }
        }// VStack
    }// body
}

