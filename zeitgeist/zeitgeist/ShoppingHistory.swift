//
//  ShoppingHistory.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 3.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation



class ShoppingHistory: ObservableObject {
    
    @Published var historyList: [String] = [""]
    
    
    init() {
        func addToList(list: [String]) {
            historyList.append(list.description)
        }
    }

}
