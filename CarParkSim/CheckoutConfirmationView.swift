//
//  CheckoutConfirmationView.swift
//  CarParkSim
//
//  Created by Vignesh on 26/12/23.
//

import SwiftUI

struct CheckoutConfirmationView: View {
    let carEntry: CarEntry
    let slotNumber: String
    let exitDateTime: Date
    
    var body: some View {
        VStack {
            Text("Car Number: \(carEntry.registrationNumber)")
            Text("Contact Number: \(carEntry.contactNumber)")
            Text("Slot Number: \(slotNumber)")
            Text("Entry Date: \(formattedDate(carEntry.entryDateTime))")
            Text("Entry Time: \(formattedTime(carEntry.entryDateTime))")
            Text("Exit Time: \(formattedTime(exitDateTime))")
            Text("Time Elapsed: \(timeElapsedSinceEntry(carEntry.entryDateTime))")
            Text("Parking Fees: \(calculateParkingFees(carEntry.entryDateTime, exitDateTime))")
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
        let elapsedTime = exitDateTime.timeIntervalSince(entryDate)
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        return String(format: "%02d hr %02d min", hours, minutes)
    }
    
    func calculateParkingFees(_ entryDate: Date, _ exitDate: Date) -> String {
        let elapsedTime = exitDate.timeIntervalSince(entryDate)
        let hours = ceil(Double(elapsedTime) / 3600.0)
        let fee = hours * 50.0
        return String(format: "₹%.2f", fee)
    }
}


struct CheckoutConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEntry = CarEntry(registrationNumber: "ABC123",
                                   contactNumber: "1234567890",
                                   entryDateTime: Date())
        
        return CheckoutConfirmationView(carEntry: sampleEntry, slotNumber: "1A", exitDateTime: Date())
    }
}
