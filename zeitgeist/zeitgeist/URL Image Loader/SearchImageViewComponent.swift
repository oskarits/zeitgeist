//
//  SearchImageViewComponent.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 4.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct SearchImageViewComponent: View {
        
        @ObservedObject var imageLoader: ImageLoader
        
        init(url: String) {
            imageLoader = ImageLoader(url: url)
        }
         
        var body: some View {
            VStack {
            Image(uiImage: ((imageLoader.data.count == 0) ? UIImage(named: "logoapple")! : UIImage(data: imageLoader.data)) ?? UIImage(systemName: "house")!)
                .resizable().scaledToFit()
            }.frame(minWidth: 150, maxWidth: 175, minHeight: 150, maxHeight: 250)
        }
        
    }
