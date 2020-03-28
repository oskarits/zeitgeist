//
//  Search.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 29.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct Search: View {
    @ObservedObject var networkingManager = NetworkingManager()
    @State private var searchText : String = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search items").padding(12)
            NavigationView {
                List {
                    ForEach(networkingManager.clothingList.items) { item in
                        if (self.searchText.isEmpty) {
                            NavigationLink(destination: VStack {
                                Text(item.brand).font(.largeTitle)
                                Text(item.size)
                                Text(item.condition)
                                Text(item.description)
                                Text("\(item.price) €")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.orange)
                            }) {
                                VStack {
                                    Text(item.brand)
                                    Text(item.size)
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.gray)
                                    Text("\(item.price) €")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.orange)
                                }
                            }
                        }
                        if (item.brand.lowercased().contains(self.searchText.lowercased())) {
                            NavigationLink(destination: VStack {
                                Text(item.brand).font(.largeTitle)
                                Text(item.size)
                                Text(item.condition)
                                Text("\(item.price) €")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.orange)
                            }) {
                                VStack {
                                    Text(item.brand)
                                    Text(item.size)
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.gray)
                                    Text("\(item.price) €")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.orange)
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Marketplace"))
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
