//
//  AddSlotsSheet.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct AddSlotsSheet: View {
    
    @State private var numberOfSlots = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var isPresentingAddSlotsSheet: Bool
    @Binding var parkingSlots: [ParkingSlot]
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section(header: Text("Slots to be added")) {
                    TextField("Enter a number from 1 to 100", text: $numberOfSlots)
                        .keyboardType(.numberPad)
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        isPresentingAddSlotsSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add Slots") {
                        validateAndAddSlots()
                    }
                }
            }
        }
    }
    
    func addSlots(_ slots: Int) {
        let startingSlotNumber = parkingSlots.count + 1
        let lastSlotNumber = parkingSlots.count + slots
        let slotsToAppend = (startingSlotNumber...lastSlotNumber).map {
            ParkingSlot(slotNumber: "\($0)", carEntry: nil)
        }
        parkingSlots += slotsToAppend
        isPresentingAddSlotsSheet = false
    }
    
    func validateAndAddSlots() {
        
        if let slots = Int(numberOfSlots) {
            if slots > 100 {
                showAlert(message: "Please enter a number from 1 to 100.")
            } else {
                addSlots(slots)
            }
        } else if numberOfSlots.isEmpty {
            showAlert(message: "Please enter a number.")
        }
    }
        
        func showAlert(message: String) {
            alertMessage = message
            showAlert = true
        }
    
}

