//
//  SignInView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 7.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI



struct SignInView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .foregroundColor(Color.orange)
            TextField("Username", text: $username)
            TextField("Password", text: $password)
            Button(action: {
                
            }) {
                Text("Sign in")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
