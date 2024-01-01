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
                            TextField("Enter a number", text: $numberOfSlots)
                                .keyboardType(.numberPad)
                       
                    }
                   
//                    if !errorMessage.isEmpty {
//                                            Text(errorMessage)
//                                                .foregroundColor(.red)
//                                                .padding(.top, 5)
//                                        }
                    
                    
                
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
    
//    func addSlots() {
//        if let slotsToAdd = Int(numberOfSlots) {
//            let startingSlotNumber = parkingSlots.count + 1
//            let lastSlotNumber = parkingSlots.count + slotsToAdd
//            let slotsToAppend = (startingSlotNumber...lastSlotNumber).map {
//                ParkingSlot(slotNumber: "\($0)", carEntry: nil)
//            }
//            parkingSlots += slotsToAppend
//            isPresentingAddSlotsSheet = false
//        }
//    }
    
    func validateAndAddSlots() {
            if numberOfSlots.isEmpty {
                showAlert(message: "Please enter a number.")
            } else if let slotsToAdd = Int(numberOfSlots) {
                let startingSlotNumber = parkingSlots.count + 1
                let lastSlotNumber = parkingSlots.count + slotsToAdd
                let slotsToAppend = (startingSlotNumber...lastSlotNumber).map {
                    ParkingSlot(slotNumber: "\($0)", carEntry: nil)
                }
                parkingSlots += slotsToAppend
                isPresentingAddSlotsSheet = false
            } else {
                showAlert(message: "Please enter a valid number.")
            }
        }
    
    func showAlert(message: String) {
            alertMessage = message
            showAlert = true
        }
}


