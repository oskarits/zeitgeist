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
        
        ScrollView {
            VStack {
                SingleItemImageView(item: item)
                VStack {
                    HStack/*(alignment: .top)*/ {
                        VStack(alignment: .leading) {
                            Text(item.brand).font(.largeTitle)
                            HStack {
                                Text("SIZE: ")
                                    .fontWeight(.bold)
                                Text(item.size)
                            }
                        }
                        Spacer()
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
                        Text(item.condition)
                        Spacer()
                    }
                    Text("")
                    HStack(alignment: .top) {
                        Text("Description: ")
                            .fontWeight(.bold)
                        Text(item.description)
                        Spacer()
                    }
                }.padding()
            }
            .onAppear {
                UIApplication.shared.endEditing(true)
            }
        }
    }
}
