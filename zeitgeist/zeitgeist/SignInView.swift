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
    @State var isLoggedIn = false
    
    @State private var ZColorUser = Color.black
    @State private var ZColorPass = Color.black
    @State private var ZColorEnvelope = Color.black
    @State private var ZColorLock = Color.black
    
    
    var body: some View {
        VStack {
            Text("Sign in")
                .font(.largeTitle)
                .foregroundColor(Color.orange)
                .padding()
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(ZColorEnvelope)
                VStack {
                    TextField("Email", text: $username, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            self.ZColorUser = Color.orange
                            self.ZColorEnvelope = Color.orange
                        } else {
                            self.ZColorUser = Color.black
                            self.ZColorEnvelope = Color.black
                        }
                    })
                        
                        .foregroundColor(ZColorUser)
                    Divider()
                        .background(ZColorUser)
                }
                
                    
            }
            .padding()
                
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(ZColorLock)
                VStack {
                    TextField("Password", text: $password, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            self.ZColorPass = Color.orange
                            self.ZColorLock = Color.orange
                        } else {
                            self.ZColorPass = Color.black
                            self.ZColorLock = Color.black
                        }
                    })
                        
                        .foregroundColor(ZColorPass)
                    Divider()
                        .background(ZColorLock)
                }
                    
            }
            .padding()
            
           
                

            Button(action: {
                self.isLoggedIn = true
                print("Logged in \(self.isLoggedIn)")
            }) {
                Text("Sign in")
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(width: 300, height: 80)
                    .background(Color.orange)
                    .cornerRadius(15.0)
                
            }.padding()
        }.padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
