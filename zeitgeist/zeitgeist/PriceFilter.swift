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
    @State var prices = stride(from: 10, through: 80, by: 10).map(String.init)

    var body: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(priceFilterTitle)
                    Image(systemName: expand2 ? "chevron.up" : "chevron.down").accessibility(identifier: "priceFilter")
                }.onTapGesture {
                    self.expand2.toggle()
                }
                Button(action: {
                    self.searchByPrice = ""
                    self.priceFilterTitle = "Price: "
                }) {
                    if (self.searchByPrice.count > 0) {
                        Image(systemName: "x.circle.fill").foregroundColor(.black)
                    }
                }.accessibility(identifier: "removePriceFilter")
            }
            // If price filter choises button is toggled open
            if expand2 {
                // Lists selectable prices
                ForEach(prices, id: \.self) { price in
                    Button(action: {
                        // Selects price for filter
                        self.searchByPrice = price
                        // Places selected price to title text
                        self.priceFilterTitle = "Price: \n" + price + "€"
                        // Closes the list of prices
                        self.expand2.toggle()
                    }) {
                        // Title text with selected price
                        Text("< " + price + "€")
                    }.accessibility(identifier: "< \(price)€") // For UI testing
                }
            }
        }// VStack
    }// body
}
