//
//  QrView.Swift
//  zeitgeist
//
//  Created by Otto Söderlund on 1.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import UIKit
import SwiftUI

struct QrView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let vc = ScannerViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: ScannerViewController, context: Context) {
    }

    class Coordinator: NSObject, QRCodeScannerDelegate {
        
        //
        func codeDidFind(_ code: String) {
            print(code)
        }
        
        var parent: QrView
        
        init(_ parent: QrView) {
            self.parent = parent
        }
    }
}

struct QRCodeScan_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }
}
