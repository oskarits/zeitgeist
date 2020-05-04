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
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkManager = CampaignNetworkManager()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ScrollView{ // If user is not logged in
                if isLoggedInResults.isEmpty {
                    VStack() {
                        Divider()
                        Text("notificationTextTitle")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text("notificationText")
                            .multilineTextAlignment(.center)
                            .padding()
                        Divider()
                        HStack {
                            Text("Sign in to share your")
                                .fontWeight(.bold)
                            Text("shareTitle2")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        }.padding(50)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { // Button to locate store(not in use)
                            Text("Store Locator")
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(width: 300, height: 80)
                                .background(Color.orange)
                                .cornerRadius(15.0)
                        }
                    }.frame(alignment: .topLeading)
                    Spacer()
                } else { // If user is logged in
                    VStack(alignment: .center) {
                        Spacer()
                        VStack {
                            // In app notification title
                            Text("notificationTextTitle")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                            // In app notification text
                            Text("notificationText")
                        }.padding(.top).padding()
                        VStack {
                            // Slogan
                            HStack {
                                Text("shareTitle1")
                                    .font(.title)
                                Text("shareTitle2")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                            // QR code with the user information
                            VStack {
                                QRMaker()
                            }.frame(maxWidth: 200, maxHeight: 200)
                        }
                        VStack { // List of campaing images
                            ForEach(networkManager.courses) { course in
                                HStack(alignment: .center) {
                                    Spacer()
                                    CampaignView(course: course)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// For canvas preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
