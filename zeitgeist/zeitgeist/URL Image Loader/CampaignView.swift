//
//  CampaignView.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 26.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import Combine

struct CampaignView: View {
    
    let course: Course
    
    var body: some View {
            ImageViewComponent(url: course.url)
    }
}
