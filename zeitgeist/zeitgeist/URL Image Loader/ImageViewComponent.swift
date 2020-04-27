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
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
     
    var body: some View {
        Image(uiImage: ((imageLoader.data.count == 0) ? UIImage(named: "logoapple")! : UIImage(data: imageLoader.data)) ?? UIImage(systemName: "house")!)
            //.resizable()
            //.aspectRatio(1, contentMode: .fit)
            //.frame(maxWidth: 300, maxHeight: 400)
    }
    
}
