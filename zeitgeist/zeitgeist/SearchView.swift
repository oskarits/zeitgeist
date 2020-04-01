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
    @State private var itemCart : [String] = []
    @State private var showPopover: Bool = false
    @State private var show = false
    @State private var selectedItem : String = ""
    @State private var shoppingCartTitleText : String = "Shopping cart"
    
    var shoppingCart: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        Text("").padding(20)
                        Spacer()
                        Text(self.shoppingCartTitleText)
                            .font(.system(size: 26, weight: .regular))
                            .foregroundColor(Color.orange)
                        Spacer()
                        Button(action: {
                            self.showPopover.toggle()
                        }) {
                            Image(systemName: "return")
                                .font(Font.system(size: 30, weight: .regular))
                        }.padding(20)
                    }
                    List{
                        
                        if itemCart != nil {
                            ForEach(itemCart, id: \.self) { item in
                                VStack {
                                    HStack {
                                        Text(item)
                                        Spacer()
                                        Button(action: {
                                            self.itemCart = self.itemCart.filter{$0 != item}
                                            
                                        }) {
                                            Image(systemName: "cart.fill.badge.minus")
                                            .font(Font.system(size: 20, weight: .regular))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var searchNavigation: some View {
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
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.brand)
                                Text(item.size)
                                    .font(.system(size: 11))
                                    .foregroundColor(Color.gray)
                                Text("\(item.price) €")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color.orange)
                            }
                            Spacer()
                            Image(systemName: "cart.fill.badge.plus").font(Font.system(size: 22, weight: .regular)).onTapGesture {
                                self.itemCart.append(item.brand)
                                self.show.toggle()
                                print("item added")
                                self.selectedItem = item.brand
                            }
                        }
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
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView{
                VStack {
                    SearchBar(text: $searchText, placeholder: "Search items")
                    List {
                        self.searchNavigation
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
                    .navigationBarItems( trailing:
                        Button(action: {
                            self.showPopover.toggle()
                        }) {
                            Image(systemName: "cart.fill")
                                .font(Font.system(size: 30, weight: .regular))
                        }
                )
                    .navigationBarTitle(Text("Search Items"))
            }.toast(show: $show, text: selectedItem)
            ZStack {
                VStack {
                    Spacer()
                    VStack{
                        VStack {
                            self.shoppingCart
                        }
                    }
                }
            }.background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .offset(x:0, y: self.showPopover ? 0 : UIApplication.shared.keyWindow?.frame.height ?? 0)
        }.resignKeyboardOnDragGesture()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


/*
 "cart.fill"
 "cart.fill.badge.plus"
 "cart.fill.badge.minus"
 */

   extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
