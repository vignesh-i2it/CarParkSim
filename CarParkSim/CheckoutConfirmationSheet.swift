//
//  CheckoutConfirmationSheet.swift
//  CarParkSim
//
//  Created by Vignesh on 26/12/23.
//

import SwiftUI

struct CheckoutConfirmationSheet: View {
    let carEntry: CarEntry
    let slotNumber: String
    //let exitDateTime: Date
    @Binding var exitDateTime: Date?
    
    @Binding var isPresentingCheckoutConfirmationSheet: Bool
//    @Binding var occupiedSlots: [Int]
//    @Binding var freeSlots: [Int]
    @Binding var parkingSlots: [String: CarEntry]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                CheckoutConfirmationView(carEntry: carEntry, slotNumber: slotNumber, exitDateTime: exitDateTime ?? Date())
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingCheckoutConfirmationSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        checkoutCar()
                    }
                }
            }
        }
    }
    
    func checkoutCar() {
        parkingSlots.removeValue(forKey: slotNumber)
        exitDateTime = Date()
        isPresentingCheckoutConfirmationSheet = false
    }
}

struct CheckoutConfirmationSheet_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEntry = CarEntry(registrationNumber: "ABC123",
                                   contactNumber: "1234567890",
                                   entryDateTime: Date())
        
        let initialParkingSlots: [String: CarEntry] = [
                    "1A": CarEntry(registrationNumber: "ABC123", contactNumber: "1234567890", entryDateTime: Date()),
                    "2A": CarEntry(registrationNumber: "DEF456", contactNumber: "9876543210", entryDateTime: Date())
                ]
        
        let exitDateTime = Calendar.current.date(byAdding: .hour, value: 2, to: Date())
        
        return CheckoutConfirmationSheet(carEntry: sampleEntry,
            slotNumber: "1A",
            exitDateTime: .constant(exitDateTime),
            isPresentingCheckoutConfirmationSheet: .constant(true),
            parkingSlots: .constant(initialParkingSlots)
        )
    }
}
