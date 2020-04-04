//
//  SingleItemView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SingleItemView: View {
    var item : ClothingListEntry
    
    var body: some View {
            VStack(alignment: .leading) {
                ImageView(item: item)
                Text(item.brand).font(.largeTitle)
                Text(item.size)
                Text(item.images[0])
                Text(item.condition)
                Text(item.description)
                Text("\(item.price) €")
                    .font(.system(size: 20))
                    .foregroundColor(Color.orange)
            }.onAppear {
                UIApplication.shared.endEditing(true)
        }
    }
}
