//
//  SignInView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 7.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData


struct SignInView: View {
    // Variable for username
    @State var username: String = ""
    // Variable for password
    @State var password: String = ""
    // Variable for user sign in
    @State var isLoggedIn = false
    // Variable for user's size
    @State var size: String = ""
    // List of selectable sizes
    @State var sizes = ["32", "34", "36", "38", "40", "42", "44"]
    // Variable to toggle list of sizes
    @State var expand = false
    // Color for user icon
    @State private var ZColorUser = Color.black
    // Color for password icon
    @State private var ZColorPass = Color.black
    // Color for letter(email) icon
    @State private var ZColorEnvelope = Color.black
    // Color for lock(password) icon
    @State private var ZColorLock = Color.black
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    var body: some View {
        VStack {
            Text("signInTitle")
                .font(.largeTitle)
                .foregroundColor(Color.orange)
                .padding()
            HStack {
                // Image icon for email
                Image(systemName: "envelope")
                    .foregroundColor(ZColorEnvelope)
                VStack {
                    // Textfield for email
                    TextField("emailHint", text: $username, onEditingChanged: {
                        // icon color change to indicate selected textfield
                        (editingChanged) in
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
                // Image icon for password
                Image(systemName: "lock")
                    .foregroundColor(ZColorLock)
                VStack {
                    // Textfield for password
                    TextField("pswdHint", text: $password, onEditingChanged: { (editingChanged) in
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
            HStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            // image icon for user size
                            Image(systemName: "scissors")
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            HStack(alignment: .center) {
                                Text(size.isEmpty ? "Select size: " : "Size: \(size)")
                                Image(systemName: expand ? "chevron.up" : "chevron.down")
                            }.onTapGesture {
                                // Toggling list of selectable sizes
                                self.expand.toggle()
                            }
                        }
                        Spacer()
                    }
                    if expand { // Shows selectable user sizes
                        ForEach(sizes, id: \.self) { size in
                            Button(action: {
                                // Selects size
                                self.size = size
                                // Toggling list of selectable sizes away
                                self.expand.toggle()
                            }) {
                                Text(size).padding(5)
                            }
                        }
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Button(action: {
                // Checks that forms are filled correctly
                if (self.username.count > 0 && self.size.count == 2) {
                    // Adds inputs to core data
                    self.addProfile(name: self.username, size: self.size)
                } else { // If form inputs are incorrect
                    print("username too short")
                }
            }) {
                Text("Sign in")
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.title)
                    .frame(width: 300, height: 80)
                    .background(Color.orange)
                    .cornerRadius(15.0)
            }
        }.padding().resignKeyboardOnDragGesture() // Removes keyboard from screen
    }
    //Adds item listing to CoreData
    func addProfile(name: String, size: String) {
        let node = LoginNode(context: managedObjectContext)
        node.idString = name
        node.size = size
        node.isLoggedIn = true //false
        saveItems()
        print("profile added")
    }
    // Changes user profile core data value to logged in
    func loggedIn(node: LoginNode) {
        let isLoggedIn = true
        let node = node
        node.isLoggedIn = isLoggedIn
        managedObjectContext.performAndWait {
            try? managedObjectContext.save()
        }
        self.isLoggedIn = true
        print("Logged in \(self.isLoggedIn)")
    }
    // Deletes core data node
    func deleteItems(indexSet: IndexSet) {
        let node = isLoggedInResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems()
    }
    // Saves profile to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
// For canvas preview
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
