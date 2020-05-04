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
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // String for search bar input
    @State private var searchText : String = ""
    // Variable for expanding size filter
    @State var expand = false
    // Variable for expanding price filter
    @State var expand2 = false
    // Variable string for searched price
    @State var searchBySize = ""
    // Variable string for searched price
    @State var searchByPrice = ""
    // Selectable sizes to filter
    @State var sizes = ["Your size", "One Size", "32", "34", "36", "38", "40", "42", "44"]
    // Selectable prices to filter
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)
    // Variable string for searched size used in Text()
    @State var sizeFilterTitle = "Size: "
    // Variable string for searched price used in Text()
    @State var priceFilterTitle = "Price: "
    // State for info overlay
    @State private var popupOpen = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView {
                VStack {
                    // Search bar for filtering by brand name
                    SearchBar(text: $searchText, placeholder: "Search by brand: ")
                    // Section for filters
                    VStack(alignment: .leading) {
                        HStack (alignment: .top){
                            Spacer()
                            Text("Search by: ")
                            Spacer()
                            // Filter by size
                            SizeFilter(searchBySize: $searchBySize, sizeFilterTitle: $sizeFilterTitle, expand: $expand, sizes: sizes)
                            Spacer()
                            // Filter by price
                            PriceFilter(searchByPrice: $searchByPrice, priceFilterTitle: $priceFilterTitle, expand2: $expand2, prices: prices)
                            Spacer()
                        }
                    }
                    // List of items by different filters
                    SearchFilters(searchText: self.$searchText, expand: self.$expand, expand2: self.$expand2, searchBySize: self.$searchBySize, searchByPrice: self.$searchByPrice, sizeFilterTitle: self.$sizeFilterTitle, priceFilterTitle: self.$priceFilterTitle)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
                    // Navigates to reservation list
                    .navigationBarItems( trailing:
                        // Info button with overlay
                        Image(systemName: "info.circle")
                        .onTapGesture {
                            self.popupOpen = !self.popupOpen
                        }
                        .background(Color.white)
                        .overlay(
                            VStack {
                                VStack {
                                    Text("Reserve to your closes Zircle store \nand pickup within 3 days")
                                }.padding()
                                .frame(width: 120, height: 150, alignment: .center)
                                
                                .font(.system(size: 11))
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                                .offset(x: -50, y: 90) // Move the view above the button
                                
                            }.opacity(popupOpen ? 1 : 0)
                            
                        )
                )
                    .navigationBarTitle(Text("Search Items"), displayMode: .inline)
            }
            // Remove keyboard by dragging down
        }.resignKeyboardOnDragGesture()
    }
}

// For canvas preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
