//
//  AddCarEntrySheet.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct AddCarEntrySheet: View {

    @Binding var isPresentingAddCarEntrySheet: Bool
    var allSlots: [String]
    @Binding var parkingSlots: [String: CarEntry]
    
    @State private var registrationNumber = ""
    @State private var contactNumber = ""
    
    var body: some View {
        NavigationStack {
            CarEntryFormView(registrationNumber: $registrationNumber, contactNumber: $contactNumber)
                .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingAddCarEntrySheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add Car") {
                        addCarEntry()
                    }
                }
            }
        }
    }
    
    func addCarEntry() {
        
        if let nearestFreeSlot = allSlots.first(where: { !parkingSlots.keys.contains($0) }) {
            let newEntry = CarEntry(registrationNumber: registrationNumber, contactNumber: contactNumber, entryDateTime: Date())
            parkingSlots[nearestFreeSlot] = newEntry
        }
        isPresentingAddCarEntrySheet = false
    }
}


