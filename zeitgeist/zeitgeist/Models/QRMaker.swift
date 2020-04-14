//
//  QRMaker.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 14.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI

struct QRMaker: View {
    @State var txt = "testi data"
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: returnData(str: self.txt))!).resizable().frame(width: 75, height: 75)
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
    
}

struct QRMaker_Previews: PreviewProvider {
    static var previews: some View {
        QRMaker()
    }
}
