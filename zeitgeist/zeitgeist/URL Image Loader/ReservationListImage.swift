//
//  ReservationListImage.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 28.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ReservationListImage: View {
        
        @ObservedObject var imageLoader: ImageLoader
        
        init(url: String) {
            imageLoader = ImageLoader(url: url)
        }
         
        var body: some View {
            VStack {
            Image(uiImage: ((imageLoader.data.count == 0) ? UIImage(named: "logoapple")! : UIImage(data: imageLoader.data)) ?? UIImage(systemName: "house")!).renderingMode(.original)
                .resizable().scaledToFit()
            }.frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200)
        }
    }
