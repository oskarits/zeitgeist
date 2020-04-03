//
//  ListItem.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    var item : ClothingListEntry
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.brand)
            Text(item.size)
                .font(.system(size: 11))
                .foregroundColor(Color.gray)
            Text("\(item.price) €")
                .font(.system(size: 11))
                .foregroundColor(Color.orange)
            Text(item.images[0])

            
        }
    }
}
