//
//  FilteredItemImageView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 26.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct FilteredItemImageView: View {

    let item : ClothingListEntry
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    
    var body: some View {
        FilteredItemImageViewComponent(url: "\(url)" + "\(item.images[0])").background(Color.white)
    }
}

struct FilteredItemImageViewComponent: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
     
    var body: some View {
        VStack {
        Image(uiImage: ((imageLoader.data.count == 0) ? UIImage(named: "logoapple")! : UIImage(data: imageLoader.data)) ?? UIImage(systemName: "house")!)
            .resizable().scaledToFit()
            //.aspectRatio(1, contentMode: .fit)
        }.frame(maxWidth: 300, maxHeight: 375)
    }
    
}
