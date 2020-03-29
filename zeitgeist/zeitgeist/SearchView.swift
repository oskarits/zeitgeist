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
    var notifier = Notificator()
    init() {
        self.notifier.PermissionRequest()
    }
    
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
                                //Text(item.description)
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

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
