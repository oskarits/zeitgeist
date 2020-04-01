//
//  QrView.swift
//  zeitgeist
//
//  Created by Otto Söderlund on 1.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//


import SwiftUI

struct QrView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QRCodeScanVC {
        let vc = QRCodeScanVC()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: QRCodeScanVC, context: Context) {
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

#if DEBUG
struct QRCodeScan_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScan()
    }
}
#endif

/*
import SwiftUI

struct QrView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }
}
*/
