//
//  SearchBar.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 30.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    // Binding string for search filter by brand name
    @Binding var text: String
    // Placeholder for empty searchbar
    var placeholder: String
    class Coordinator: NSObject, UISearchBarDelegate {
        // Binding string for search filter by brand name
        @Binding var text: String
        // Initialising the text string
        init(text: Binding<String>) {
            _text = text
        }
        // Show cancel button when searchbar is not empty
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchBar.showsCancelButton = true
        }
        // Show cancel button when searchbar is not empty
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        // Unselect searchbar
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        // When cancel button is pressed
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            //searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
    // Return function
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    // Styling of the searchbar
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.showsCancelButton = true
        return searchBar
    }
    // Update UI
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
