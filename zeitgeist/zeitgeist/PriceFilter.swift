//
//  PriceFilter.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct PriceFilter: View {
    // Binding value for string value of searched price
    @Binding var searchByPrice: String
    // Binding value for string value of searched price used in Text()
    @Binding var priceFilterTitle: String
    // Binding value for expanding price filter
    @Binding var expand2: Bool
    // Selectable prices to filter
    @State var prices = ["0 - 10", "10 - 20", "20 - 30", "30 - 40", "40 - 50", "50 - 60", "60 - 70", "70 - 80", "80 - 90"]
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(priceFilterTitle)
                    Image(systemName: expand2 ? "chevron.up" : "chevron.down").accessibility(identifier: "priceFilter") // For UI testing
                }.onTapGesture { // Opens selectable list of prices
                    self.expand2.toggle()
                }
                // Button to remove price filter
                Button(action: {
                    self.searchByPrice = ""
                    self.priceFilterTitle = "Price: "
                }) {
                    if (self.searchByPrice.count > 0) {
                        Image(systemName: "x.circle.fill").foregroundColor(.black)
                    }
                }.accessibility(identifier: "removePriceFilter") // For UI testing
            }
            // If price filter choises button is toggled open
            if expand2 {
                // Lists selectable prices
                ForEach(prices, id: \.self) { price in
                    // VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        // Selects price for filter
                        self.searchByPrice = price
                        //self.searchByPrice = String(price.suffix(2))
                        print(self.searchByPrice.suffix(2))
                        // Places selected price to title text
                        self.priceFilterTitle = "Price: \n" + price + "€"
                        // Closes the list of prices
                        self.expand2.toggle()
                    }) {
                        // Title text with selected price
                        HStack {
                            Text(price)
                                .foregroundColor(Color.black)
                            Text("€")
                                .foregroundColor(Color.orange)
                                .fontWeight(.medium)
                        }
                    }.frame(maxHeight: 10).accessibility(identifier: "\(price)") // For UI testing                    
                }
            }
        }// VStack
    }// body
}
