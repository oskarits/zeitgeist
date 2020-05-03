//
//  QRMaker.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 14.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
import CoreImage.CIFilterBuiltins


struct QRMaker: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    var body: some View {
        VStack {
            VStack { // Checks if core data for profile exists
                if (isLoggedInResults.endIndex > 0) {
                    // Checks if user is logged in
                    if (isLoggedInResults[0].isLoggedIn) {
                        // Generates qr code image from core data
                        Image(uiImage: self.generateQRCode(from: isLoggedInResults[0].idString))
                            .interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 200)
                        Divider()
                    }
                }
            }.frame(maxWidth: 200)
        }.frame(maxWidth: 200)
    }
    // Generates QR code image
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
// For canvas preview
struct QRMaker_Previews: PreviewProvider {
    static var previews: some View {
        QRMaker()
    }
}
