//
//  DataView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 25.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI

struct DataView: View {

    @ObservedObject var networkingManager = NetworkingManager()
    
    var body: some View {
        NavigationView() {
            List(networkingManager.clothingList.items) { item in
                // Makes list item clickable and opens in own view
                NavigationLink(destination: VStack {
                    Text(item.brand).font(.largeTitle)
                    Text(item.size)
                    Text(item.condition)
                    Text("\(item.price) €")
                        .font(.system(size: 20))
                        .foregroundColor(Color.orange)
                }) {
                // List items
                VStack(alignment: .leading) {
                    Text(item.brand)
                    Text(item.size)
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                    Text("\(item.price) €")
                        .font(.system(size: 11))
                        .foregroundColor(Color.orange)
                }.padding()
                }
            }
        }
        .navigationBarTitle(Text("Marketplace"))
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
