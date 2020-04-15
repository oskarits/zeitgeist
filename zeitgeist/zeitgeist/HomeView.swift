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

    var body: some View {
        
        VStack {
            NavigationView {
                VStack(alignment: .center) {
                    HStack {
                        Text("shareTitle1")
                        Text("shareTitle2").foregroundColor(Color.orange)
                    }
                    QRMaker()
                    List(networkManager.courses) { course in
                        CampaignView(course: course)
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

