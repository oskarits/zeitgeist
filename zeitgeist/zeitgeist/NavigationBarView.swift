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
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Initialises colors for the TabView
    init() {
        // Color for unselected tab
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            // Shows HomeView()
            HomeView()
                .tabItem {
                    // Image icon for the tab
                    Image(systemName: "house").font(Font.system(size: 30, weight: .regular))
            }
            // If user is not logged in, shows SignInView()
            if isLoggedInResults.isEmpty {
                SignInView().tabItem {
                    // Image icon for the tab
                    Image(systemName: "person").font(Font.system(size: 30, weight: .regular))
                }
            } else { // If user is logged in, shows ProfileView()
                ProfileView().tabItem {
                    // Image icon for the tab
                    Image(systemName: "person").font(Font.system(size: 30, weight: .regular))
                }
            }
            // Shows TabBar()
            TabBar()
                .tabItem {
                    // Image icon for the tab
                    Image(systemName: "magnifyingglass").font(Font.system(size: 30, weight: .regular))
            }
            // Shows QrView()
            QrView()
                .tabItem {
                    // Image icon for the tab
                    Image(systemName: "barcode").font(Font.system(size: 30, weight: .regular))
            }
            // Shows EmployeeView()
            EmployeeView()
                .tabItem {
                    // Image icon for the tab
                    Image("zircle").resizable().frame(width: 30, height: 30)}
        }
    }
    
    // For canvas preview
    struct NavigationBarView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationBarView()
        }
    }
}
