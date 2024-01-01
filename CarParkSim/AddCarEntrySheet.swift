//
//  AddCarEntrySheet.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct AddCarEntrySheet: View {
    

    @State private var registrationNumber = ""
    @State private var contactNumber = ""

    @Binding var isPresentingAddCarEntrySheet: Bool
    @Binding var parkingSlots: [ParkingSlot]

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
        if let index = parkingSlots.firstIndex(where: { $0.carEntry == nil }) {
            let newEntry = CarEntry(registrationNumber: registrationNumber, contactNumber: contactNumber, entryDateTime: Date())
            parkingSlots[index].carEntry = newEntry
            print(index)
        }
        print(parkingSlots[0].carEntry?.registrationNumber ?? "No car parked in this slot.")
        isPresentingAddCarEntrySheet = false
    }
}


