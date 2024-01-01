//
//  CarEntryFormView.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct CarEntryFormView: View {

    @Binding var registrationNumber: String
    @Binding var contactNumber: String
    
    var body: some View {
        Form {
            Section(header: Text("Car Number")) {
                TextField("Enter registration number", text: $registrationNumber)
            }
            
            Section(header: Text("Contact Details")) {
                TextField("Enter phone number ", text: $contactNumber)
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct CarEntryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CarEntryFormView(
            registrationNumber: .constant("TN 01 WJ 3212"),
            contactNumber: .constant("87654 87652")
        )
    }
}
