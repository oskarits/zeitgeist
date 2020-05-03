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
            ScrollView{
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
                        Image("zalandoCampaignBlurred")
                            .resizable()
                            .frame(width: 380, height: 240)
                            .padding()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Store Locator")
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(width: 300, height: 80)
                                .background(Color.orange)
                                .cornerRadius(15.0)
                        }
                    }.frame(alignment: .topLeading)
                    Spacer()
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        VStack {
                            Text("notificationTextTitle")
                                .fontWeight(.bold)
                                
                                .foregroundColor(.red)
                            Text("notificationText")
                        }.padding(.top).padding()
                        
                        VStack {
                            HStack {
                                
                                Text("shareTitle1")
                                    .font(.title)
                                Text("shareTitle2")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                            VStack {
                                QRMaker()
                            }.frame(maxWidth: 200, maxHeight: 200)
                        }
                        VStack {
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



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

