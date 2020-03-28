//
//  SingleResult.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ClothingList: Decodable {
    var items: [ClothingListEntry]
}

struct ClothingListEntry: Decodable, Identifiable {
    var id = UUID()
    var brand: String
    var size: String
    var condition: String
    var price: String
    var description: String
}

//struct Clothing: Decodable, Hashable ,Identifiable {
//    var id: Int
//    var brand: String
//    var size: String
//    var condition: String
//    var price: String
//}
//
//struct ClothingFeed: Decodable {
//    var results: [Clothing]
//}
//
//struct ClothingResult: Decodable {
//    var feed: ClothingFeed
//}
//
