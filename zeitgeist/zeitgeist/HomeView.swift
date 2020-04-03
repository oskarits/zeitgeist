//
//  HomeView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var networkManager = CampaignNetworkManager()
    @ObservedObject var networkManager2 = NetworkingManager()

    var body: some View {
        
        VStack {
            NavigationView {
                VStack(alignment: .center) {
                    HStack {
                        Text("Share your")
                        Text("wardrobe").foregroundColor(Color.orange)
                    }
                    Image("qrCode")
                        .resizable()
                        .frame(width: 200, height: 200)
                    List(networkManager.courses) { course in
                        CampaignView(course: course)
                    }
                    List(networkManager2.clothingList.items) { item in
                        ImageView(item: item)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

