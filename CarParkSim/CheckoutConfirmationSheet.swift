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
    
    @Binding var exitDateTime: Date?
    @Binding var isPresentingCheckoutConfirmationSheet: Bool
    @Binding var parkingSlots: [String: CarEntry]
        
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
