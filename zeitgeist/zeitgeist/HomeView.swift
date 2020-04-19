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
        
        VStack {
            NavigationView {
                VStack(alignment: .center) {
                    HStack {
                        Text("shareTitle1")
                        Text("shareTitle2").foregroundColor(Color.orange)
                    }
                    QRMaker()
                    Spacer()
                    VStack {
                        if !isLoggedInResults.isEmpty {
                            List(networkManager.courses) { course in
                                CampaignView(course: course)
                            }
                        } else {
                            guard let zBlurrred = UIImage(named: "zalandoCampaignBlurred") else { return }
                            zBlurrred
        
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

