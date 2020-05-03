//
//  SingleItemView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SingleItemView: View {
    // Placeholder for decodable variables
    var item : ClothingListEntry
    
    var body: some View {
        ScrollView {
            VStack {
                // Displays item image
                SingleItemImageView(item: item)
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            // Item brand name
                            Text(item.brand).font(.largeTitle)
                            HStack {
                                Text("SIZE: ")
                                    .fontWeight(.bold)
                                // Item size
                                Text(item.size)
                            }
                        }
                        Spacer()
                        // Item price
                        Text("\(item.price) €")
                            .font(.system(size: 25))
                            .foregroundColor(Color.orange)
                            .fontWeight(.bold)
                    }
                }.padding()
                VStack {
                    HStack(alignment: .top) {
                        Text("Condition: ")
                            .fontWeight(.bold)
                        // Item condition
                        Text(item.condition)
                        Spacer()
                    }
                    Text("")
                    HStack(alignment: .top) {
                        Text("Description: ")
                            .fontWeight(.bold)
                        // Item description
                        Text(item.description)
                        Spacer()
                    }
                }.padding()
            }
            .onAppear { // Toggles keyboard down
                UIApplication.shared.endEditing(true)
            }
        }
    }
}
