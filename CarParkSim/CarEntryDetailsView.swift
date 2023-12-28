//
//  CarEntryDetailsView.swift
//  CarParkSim
//
//  Created by Vignesh on 26/12/23.
//

import SwiftUI

struct CarEntryDetailsView: View {
    
    @State private var isPresentingCheckoutConfirmationSheet = false
    @State private var exitDateTime: Date?
    
    let carEntry: CarEntry
    let slotNumber: String
    
    @Binding var parkingSlots: [String: CarEntry]
    

    var body: some View {
        VStack {
            Text("Car Number: \(carEntry.registrationNumber)")
            Text("Contact Number: \(carEntry.contactNumber)")
            if exitDateTime == nil {
                Text("Slot Number: \(slotNumber)")
            }
            Text("Entry Date: \(formattedDate(carEntry.entryDateTime))")
            Text("Entry Time: \(formattedTime(carEntry.entryDateTime))")
            if let exitDateTime = exitDateTime {
                Text("Exit Date: \(formattedDate(exitDateTime))")
                Text("Exit Time: \(formattedTime(exitDateTime))")
            } else {
                Text("Time Elapsed: \(timeElapsedSinceEntry(carEntry.entryDateTime))")

            }
        }
        .navigationTitle(exitDateTime != nil ? "Exit Details" : "Entry Details")
        .toolbar {
            if exitDateTime == nil {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Checkout") {
                        isPresentingCheckoutConfirmationSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingCheckoutConfirmationSheet) {
            CheckoutConfirmationSheet(
                carEntry: carEntry,
                slotNumber: slotNumber,
                exitDateTime: $exitDateTime,
                isPresentingCheckoutConfirmationSheet: $isPresentingCheckoutConfirmationSheet,
                parkingSlots: $parkingSlots
            )
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func timeElapsedSinceEntry(_ entryDate: Date) -> String {
        let elapsedTime = Date().timeIntervalSince(entryDate)
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        return String(format: "%02d hr %02d min", hours, minutes)
    }
}

struct CarEntryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
    let sampleEntry = CarEntry(registrationNumber: "ABC123",
                               contactNumber: "1234567890",
                               entryDateTime: Date())
        
    let initialParkingSlots: [String: CarEntry] = [
                "1A": CarEntry(registrationNumber: "ABC123", contactNumber: "1234567890", entryDateTime: Date()),
                "1B": CarEntry(registrationNumber: "DEF456", contactNumber: "9876543210", entryDateTime: Date())
            ]
        
    return CarEntryDetailsView(carEntry: sampleEntry,
            slotNumber: "1A",
            parkingSlots: .constant(initialParkingSlots)
        )
    }
}
