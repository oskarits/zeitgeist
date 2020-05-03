//
//  ImageViewComponent.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 28.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct ImageViewComponent: View {
    // Placeholder for ObservableObject ImageLoader
    @ObservedObject var imageLoader: ImageLoader
    // Initialising item image URL
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        VStack { // Place image from URL and nil guards
            Image(uiImage: ((imageLoader.data.count == 0) ? UIImage(named: "logoapple")! : UIImage(data: imageLoader.data)) ?? UIImage(systemName: "house")!)
                .resizable().scaledToFit()
        }.frame(minWidth: 350, maxWidth: 375, minHeight: 350, maxHeight: 650) // Size for image frame
    }
}
