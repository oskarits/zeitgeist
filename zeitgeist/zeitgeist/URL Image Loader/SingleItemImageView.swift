//
//  SingleItemImageView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 26.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct SingleItemImageView: View {
    // Placeholder for decodable variables
    let item : ClothingListEntry
    // URL for image fetching
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    
    var body: some View {
        SingleSearchImageViewComponent(url: "\(url)" + "\(item.images[0])").background(Color.white)
    }
}

struct SingleSearchImageViewComponent: View {
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
        }.frame(maxWidth: 400, maxHeight: 500) // Size for image fram
    }
    
}
