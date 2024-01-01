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
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Binding var isPresentingAddCarEntrySheet: Bool
    @Binding var parkingSlots: [ParkingSlot]

    var body: some View {
        NavigationStack {
            CarEntryFormView(registrationNumber: $registrationNumber, contactNumber: $contactNumber)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingAddCarEntrySheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add Car") {
                        validateAndAddCarEntry()
                    }
                }
            }
        }
    }
    
    func validateAndAddCarEntry() {
        if registrationNumber.isEmpty || contactNumber.isEmpty {
            showAlert(message: "Please fill out both registration number and contact number.")
        } else if contactNumber.count != 10 {
            showAlert(message: "Contact number should have 10 digits.")
        } else {
            addCarEntry()
        }
    }

    func addCarEntry() {
        if let index = parkingSlots.firstIndex(where: { $0.carEntry == nil }) {
            let newEntry = CarEntry(registrationNumber: registrationNumber, contactNumber: contactNumber, entryDateTime: Date())
            parkingSlots[index].carEntry = newEntry
        }
        isPresentingAddCarEntrySheet = false
    }

    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}


