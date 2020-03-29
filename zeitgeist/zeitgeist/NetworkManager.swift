//
//  NetworkingManager.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 25.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkingManager,Never>()
    
   @Published var clothingList = ClothingList(items: [])

    
    init() {
        guard let url = URL(string: "https://www.zalando-wardrobe.de/api/items?page=3n") else { return }
        
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode(ClothingList.self, from: d)
                    DispatchQueue.main.async {
                        self.clothingList = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
    }
}


struct ClothingList: Decodable {
    var items: [ClothingListEntry]
}

struct ClothingListEntry: Decodable, Identifiable {
    var id = UUID()
    var brand: String
    var size: String
    var condition: String
    var price: String
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
