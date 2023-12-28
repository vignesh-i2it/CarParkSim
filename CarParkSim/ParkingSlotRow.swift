//
//  ParkingSlotRow.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct ParkingSlotRow: View {
    let slotNumber: String
    let carEntry: CarEntry?

    @Binding var parkingSlots: [String: CarEntry]
    
    var body: some View {
        
        if let entry = carEntry {
                NavigationLink(destination: CarEntryDetailsView(
                        carEntry: entry,
                        slotNumber: slotNumber,
                        parkingSlots: $parkingSlots
                    )
                ) {
                    rowContent(entry)
                }
            } else {
                rowContent(nil)
                    .padding(7)
            }
        }
        
//        HStack {
//                    Spacer()
//                    if let entry = carEntry {
//                        VStack(spacing: 4) {
//                            Text("\(entry.registrationNumber)")
//                            Text("\(formattedTime(date: entry.entryDateTime))")
//                            Text("\(entry.contactNumber)")
//                        }
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                        .background(Color.secondary.opacity(0.2))
//                    } else {
//                        Text("Available")
//                    }
//                    Spacer()
//                }
//                .overlay(
//                    ZStack {
//                        Text("Slot \(slotNumber)")
//                            .foregroundColor(.white)
//                            .padding(4)
//                            .background(Color.blue)
//                            .clipShape(Capsule())
//                            .padding(.horizontal, 8)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    , alignment: .leading
//                )
//                .padding(.vertical, 8)
//

    @ViewBuilder
    private func rowContent(_ entry: CarEntry?) -> some View {
        HStack {
            Text("\(slotNumber)")
            Spacer()
            if let entry = carEntry {
                VStack(alignment: .trailing) {
                    Text("\(entry.registrationNumber)")
                    Text("\(formattedTime(date: entry.entryDateTime))")
                    Text("\(entry.contactNumber)")
                }
            } else {
                VStack(alignment: .trailing) {
                    Text("")
                        .foregroundColor(.clear)
                    Text("Available")
                        .foregroundColor(.green)
                    Text("")
                        .foregroundColor(.clear)
                }
            }
        }
    }
    
    func formattedTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}

struct ParkingSlotRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let initialParkingSlots: [String: CarEntry] = [
                    "1A": CarEntry(registrationNumber: "ABC123", contactNumber: "1234567890", entryDateTime: Date()),
                    "1B": CarEntry(registrationNumber: "DEF456", contactNumber: "9876543210", entryDateTime: Date())
                ]
        
        ParkingSlotRow(slotNumber: "1A", carEntry: nil,
//                       occupiedSlots: .constant([1, 3]),
//                       freeSlots: .constant([2, 4, 5, 6]),
                       parkingSlots: .constant(initialParkingSlots))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
