//
//  SizeFilter.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 18.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SizeFilter: View {
        
    @Binding var searchBySize: String
    @Binding var sizeFilterTitle: String
    @Binding var expand: Bool
    @State var sizes = ["Your size", "One Size", "32", "34", "36", "38", "40", "42", "44"]

    var body: some View {
        VStack(spacing: 30) {
            HStack {
                HStack {
                    Text(sizeFilterTitle)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                }.onTapGesture {
                    self.expand.toggle()
                }
                Button(action: {
                    self.searchBySize = ""
                    self.sizeFilterTitle = "Size: "
                }) {
                    if (self.searchBySize.count > 0) {
                        Image(systemName: "x.circle.fill").foregroundColor(.black)
                    }
                }
            }
            if expand {
                ForEach(sizes, id: \.self) { size in
                    Button(action: {
                        self.searchBySize = size
                        self.sizeFilterTitle = "Size: \n" + size
                        self.expand.toggle()
                    }) {
                        Text(size)
                    }
                }
            }
        }
        
    }
}
