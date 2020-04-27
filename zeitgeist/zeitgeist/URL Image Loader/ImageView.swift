//
//  ImageView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 3.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {

    let item : ClothingListEntry
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    
    var body: some View {
        SearchImageViewComponent(url: "\(url)" + "\(item.images[0])").background(Color.white)
    }
}
