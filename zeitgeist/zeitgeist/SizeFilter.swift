//
//  SizeFilter.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SizeFilter: View {
    // Binding value for string value of searched size
    @Binding var searchBySize: String
    // Binding value for string value of searched size used in Text()
    @Binding var sizeFilterTitle: String
    // Binding value for expanding size filter
    @Binding var expand: Bool
    // Selectable sizes to filter
    @State var sizes = ["Your size", "One Size", "32", "34", "36", "38", "40", "42", "44"]
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(sizeFilterTitle)
                    Image(systemName: expand ? "chevron.up" : "chevron.down").accessibility(identifier: "sizeFilter") // For UI testing
                }.onTapGesture {// Opens selectable list of sizes
                    self.expand.toggle()
                }
                // Button to remove size filter
                Button(action: {
                    self.searchBySize = ""
                    self.sizeFilterTitle = "Size: "
                }) {
                    if (self.searchBySize.count > 0) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.black)
                    }
                }.accessibility(identifier: "removeSizeFilter") // For UI testing
            }
            // If size filter choises button is toggled open
            if expand {
                // Lists selectable sizes
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        // Selects size for filter
                        self.searchBySize = size
                        // Places selected size to title text
                        self.sizeFilterTitle = "Size: \n" + size
                        // Closes the list of sizes
                        self.expand.toggle()
                    }) {
                        // Title text with selected size
                        Text(size)
                    }.accessibility(identifier: "\(size)") // For UI testing
                }
            }
        }// VStack
    }// body
}
