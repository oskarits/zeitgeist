//
//  NavigationView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
struct NavigationBarView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    init() {
        
        // For unselected
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.white
        
    }
    
    var body: some View {
        TabView {
            //SignInView()
            HomeView()
                .tabItem {
                    Image(systemName: "house").font(Font.system(size: 30, weight: .regular))
            }
            //SearchView()
            TabBar()
                .tabItem {
                    Image(systemName: "magnifyingglass").font(Font.system(size: 30, weight: .regular))
            }
            //ItemNodeView()
            
            if isLoggedInResults.isEmpty {
                SignInView().tabItem {
                        Image(systemName: "person").font(Font.system(size: 30, weight: .regular))
                }
            } else {
                ProfileView().tabItem {
                        Image(systemName: "person").font(Font.system(size: 30, weight: .regular))
                }
            }
                
            
            ItemNodeView()
            //QrView()
                .tabItem {
                    Image(systemName: "barcode").font(Font.system(size: 30, weight: .regular))
            }
            EmployeeView()
                .tabItem {
                    Image("zircle").resizable().frame(width: 30, height: 30)}
        }
    }


struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
}
