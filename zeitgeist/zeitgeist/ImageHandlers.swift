//
//  ImageHandlers.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 26.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation

struct ImageRow: View {
    let model: Post
    var body: some View {
        VStack(alignment: .center) {
            ImageViewContainer(imageUrl: model.avatar_url)
        }
    }
}

struct ImageViewContainer: View {
    @Published var campaignNetworkManager = CampaignNetworkManager()

    init(imageUrl: String) {
        campaignNetworkManager(imageUrl: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: campaignNetworkManager.campaignList.items) ?? UIImage())
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 3.0))
            .frame(width: 70.0, height: 70.0)
    }
}
