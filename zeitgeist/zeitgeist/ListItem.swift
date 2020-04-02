//
//  ListItem.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct ListItem: View {
    var item : ClothingListEntry
    
    var body: some View {
        Text(item.brand)
    }
}
