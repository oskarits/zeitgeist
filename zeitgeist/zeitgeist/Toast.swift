//
//  Toast.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 1.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ToastView<Content>: View where Content: View {
    // Binding variable to show 'Toast'
    @Binding var show: Bool
    // String for the 'Toast'
    let text: String
    var overlaidContent: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.overlaidContent()
                if self.show {
                    HStack {
                        Text("item1").foregroundColor(Color.white)
                        Text(self.text)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.orange)
                        Text("item2").foregroundColor(Color.white)
                    }.padding()
                        .frame(width: geometry.size.width < geometry.size.height ? geometry.size.width * 0.85 : geometry.size.width * 0.65)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(20)
                        .padding([.vertical], 15)
                        .animation(.easeInOut(duration: 1.0))
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            // Async to hide the 'Toast' view
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.show.toggle()
                            }
                    }
                }
            }
        }
    }
}
// Called when showing 'Toast'
extension View {
    func toast(show: Binding<Bool>, text: String) -> some View {
        ToastView(show: show, text: text) {
            self
        }
    }
}
