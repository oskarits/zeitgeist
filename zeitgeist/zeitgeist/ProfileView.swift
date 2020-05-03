//
//  ProfileView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    // Variable for notification call function
    var notification = Notification()
    // String for notification title
    @State private var notificationTitle : String = "Title test"
    // String for notification body
    @State private var notificationBody : String = "Body test"
    // Toggle notification
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Shows ProfileInfo()
                ProfileInfo()
            }.navigationBarTitle(Text("profileTitle"), displayMode: .inline).foregroundColor(Color.black)
        }
    }
}


struct Detail : View {
    @Binding var show : Bool
    var body: some View {
        Text("notificationBody")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
