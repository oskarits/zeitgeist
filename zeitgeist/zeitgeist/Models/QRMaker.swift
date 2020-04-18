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
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    
    var body: some View {
        VStack {
            VStack {
                if (isLoggedInResults[0].isLoggedIn) {
                    Image(uiImage: self.generateQRCode(from: isLoggedInResults[0].idString))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                }
            }
        }
    }
    
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

struct QRMaker_Previews: PreviewProvider {
    static var previews: some View {
        QRMaker()
    }
}
