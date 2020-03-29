//
//  NewsFeedModel.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 25.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Course: Identifiable, Decodable {
    let id = UUID()
    var name: String
    var url: String
}


//struct CampaignList: Decodable {
//    var items: [CampaignListItem]
//}
//
//struct CampaignListItem: Decodable, Identifiable {
//    var id = UUID()
//    var name: String
//    var url: String
//}
