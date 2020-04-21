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
            //ImageView(item: item)
            Text(item.brand).foregroundColor(Color.black)
                .fontWeight(.medium)
            Text("SIZE: \(item.size)").foregroundColor(Color.black)
                .font(.system(size: 11))
                //.foregroundColor(Color.gray)
            //.fontWeight(.light)
            Text("\(item.price) €").foregroundColor(Color.black)
                .font(.system(size: 11))
                .foregroundColor(Color.orange)
                .fontWeight(.regular)
            //Text(item.images[0])
        }.padding(5)
    }
}
