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
    
    //---
    @State var txt = "testi data"
    
    var body: some View {
        VStack {
            List {
                ForEach(isLoggedInResults, id: \.self) { node in
                    
                    VStack {
                        if (node.isLoggedIn) {
                            Image(uiImage: UIImage(data: self.returnData(str: node.idString))!).interpolation(.none).resizable().frame(width: 150, height: 150)
                        }
                        if (node.isLoggedIn == false) {
                            Image(uiImage: UIImage(data: self.returnData(str: self.txt))!).interpolation(.none).resizable().frame(width: 150, height: 150)
                        }
                        Image(uiImage: self.generateQRCode(from: "aaaaaaaaa")).interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        
                        
                    }
                    
                    
                }
            }
        }
    }
    
    
    func returnData(str : String) -> Data {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let data = str.data(using: .ascii, allowLossyConversion: false)
        filter?.setValue(data, forKey: "inputMessage")
        let image = filter?.outputImage
        let uiImage = UIImage(ciImage: image!)
        return uiImage.pngData()!
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
