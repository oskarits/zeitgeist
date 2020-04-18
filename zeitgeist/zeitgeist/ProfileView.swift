//
//  ProfileView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
//    @ObservedObject var shoppingHistory = ShoppingHistory()
    var notification = Notification()
    @State private var notificationTitle : String = "Title test"
    @State private var notificationBody : String = "Body test"
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileInfo()
            }.navigationBarTitle(Text("profileTitle"), displayMode: .inline)
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
