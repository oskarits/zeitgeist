//
//  WaterfallView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 20.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
import WaterfallGrid


struct WaterfallView: View {
    
    @ObservedObject var networkingManager = NetworkingManager()
    
    var body: some View {
        VStack{
            WaterfallGrid(self.networkingManager.clothingList.items) {item in
                SearchNavigation(item: item)
            }
        }
    }
}
/*
VStack{
    WaterfallGrid(self.networkingManager.clothingList.items) {item in
        SearchNavigation(item: item)
    }
}
*/
