//
//  ProfileView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var shoppingHistory = ShoppingHistory()
    var notification = Notification()
    @State private var notificationTitle : String = "Title test"
    @State private var notificationBody : String = "Body test"
    @State var show = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
//                NavigationLink(destination: Detail(show: self.$show), isActive: self.$show) {
//                    Text("")
//                }
                NavigationLink(destination: ReservationList()) {
                    Text("Check your reservations")
                }
//                Button(action: {
//                    self.notification.SendNotification(title: self.notificationTitle, body: self.notificationBody)
//                }) {
//                    Text("Send notification")
//                }
            }
                .navigationBarTitle(Text("Profile"), displayMode: .inline)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { (_) in
                        self.show = true
                    }
                }
        }
            
    }
}


struct Detail : View {
    @Binding var show : Bool
    var body: some View {
        Text("Test body for notification link")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
