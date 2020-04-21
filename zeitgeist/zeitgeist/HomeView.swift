//
//  HomeView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    @ObservedObject var networkManager = CampaignNetworkManager()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationView {
                VStack(alignment: .leading) {
                    if isLoggedInResults.isEmpty {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Sign in to share your")
                                    .fontWeight(.bold)
                                Text("shareTitle2")
                                    .foregroundColor(.orange)
                                    .fontWeight(.bold)
                            }.padding(50)
                            Image("zalandoCampaignBlurred")
                                .resizable()
                                .frame(width: 380, height: 240)
                        }.frame(alignment: .topLeading)
                            .background(Color.red)
                    } else {
                        VStack(alignment: .center) {
                            HStack {
                                Text("shareTitle1")
                                Text("shareTitle2")
                                    .foregroundColor(.orange)
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

