//
//  PriceFilter.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct PriceFilter: View {
    @Binding var searchByPrice: String
    @Binding var priceFilterTitle: String
    @Binding var expand2: Bool
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
                    }                }
            }
            if expand2 {
                ForEach(prices, id: \.self) { price in
                    Button(action: {
                        self.searchByPrice = price
                        self.priceFilterTitle = "Price: \n" + price + "€"
                        self.expand2.toggle()
                    }) {
                        Text("< " + price + "€")
                    }
                }
            }
        }
        
    }

}
