//
//  ListItem.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    // Placeholder for decodable variables
    var item : ClothingListEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            // Item brand name
            Text(item.brand).foregroundColor(Color.black)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .lineLimit(1)
            // Item size
            HStack {
                Text("sizeText")
                Text("\(item.size)")
            }
                .foregroundColor(Color.black)
                .font(.system(size: 12))
            // Item price
            Text("\(item.price) €")
                .font(.system(size: 12))
                .foregroundColor(Color.orange)
                .fontWeight(.medium)
        }.padding(5)
    }
}
