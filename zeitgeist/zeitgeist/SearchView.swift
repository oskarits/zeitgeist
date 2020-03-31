//
//  SearchView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var networkingManager = NetworkingManager()
    @State private var searchText : String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView{
                VStack {
                    SearchBar(text: $searchText, placeholder: "Search items")
                    List {
                        ForEach(networkingManager.clothingList.items) { item in
                            if (self.searchText.isEmpty) {
                                NavigationLink(destination:
                                    VStack(alignment: .leading) {
                                        Text(item.brand).font(.largeTitle)
                                        Text(item.size)
                                        Text(item.condition)
                                        Text(item.description)
                                        Text("\(item.price) €")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.orange)
                                    }.onAppear {
                                        UIApplication.shared.endEditing(true)
                                }) {
                                    VStack(alignment: .leading) {
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
                                NavigationLink(destination:
                                    VStack(alignment: .leading) {
                                        Text(item.brand).font(.largeTitle)
                                        Text(item.size)
                                        Text(item.condition)
                                        Text("\(item.price) €")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.orange)
                                    }.onAppear {
                                        UIApplication.shared.endEditing(true)
                                }) {
                                    VStack(alignment: .leading) {
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
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .navigationBarItems(leading: Image(systemName: "house").font(Font.system(size: 30, weight: .regular))).navigationBarTitle(Text("Search Items"))
            }
        }.resignKeyboardOnDragGesture()
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

