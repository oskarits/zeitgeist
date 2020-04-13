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
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: ReservationView()) {
                        VStack {
                            Image(systemName: "pencil.and.outline")
                            Text("showReservationsText").padding(.horizontal)
                        }
                        VStack {
                            Image(systemName: "barcode.viewfinder")
                            Text("scanQRText").padding(.horizontal)
                        }
                    }.padding()
                }
                .font(.title)
                .multilineTextAlignment(.center)
                
                .cornerRadius(8)
                .navigationBarTitle(Text("employeeTitle"), displayMode: .inline)
            }
        }
    }
}


struct EployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView()
    }
}
