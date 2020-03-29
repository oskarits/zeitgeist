//
//  CampaignNetworkManager.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 25.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CampaignNetworkManager: ObservableObject {

    @Published var courses = [Course]()

    
    init() {
        guard let url = URL(string: "http://users.metropolia.fi/~tuomamp/zalandonCampaignData.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let courses = try! JSONDecoder().decode([Course].self, from: data)
            DispatchQueue.main.async {
                self.courses = courses
            }
        }.resume()
    }
}
