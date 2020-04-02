//
//  EmployeeView.swift
//  zeitgeist
//
//  Created by Oskari Sieranen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI

struct EmployeeView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                VStack {
                    Image(systemName: "pencil.and.outline")
                    Text("Show\nReservations").padding(.horizontal)
                }
            }.padding()
            Button(action: {}) {
                VStack {
                    Image(systemName: "barcode.viewfinder")
                    Text("Scan\nQR").padding(.horizontal)
                }
            }.padding()
        }
        .font(.title)
        .multilineTextAlignment(.center)
        .foregroundColor(.orange)
        .cornerRadius(8)
    }
}


struct EployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView()
    }
}
