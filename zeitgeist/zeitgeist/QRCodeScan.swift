//
//  QRCodeScan.swift
//  zeitgeist
//
//  Created by Otto Söderlund on 1.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import UIKit
import SwiftUI

struct QRCodeScan: UIViewControllerRepresentable {
    
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
        
        func codeDidFind(_ code: String) {
            print(code)
        }
        
        var parent: QRCodeScan
        
        init(_ parent: QRCodeScan) {
            self.parent = parent
        }
    }
}

struct QRCodeScan_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScan()
    }
}
