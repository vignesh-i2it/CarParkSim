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

    @Binding var parkingSlots: [ParkingSlot]
    @Binding var isPresentingCheckoutBill: Bool
    @Binding var slotExited: String
    @Binding var carExited: CarEntry?
        
    var body: some View {
        
        if let entry = carEntry {
                rowContent(entry)
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
                //.padding(.leading, 10)
            
            if let entry = carEntry {
                HStack{
                    VStack(alignment: .leading) {
                        Text("Registration no.: \(entry.registrationNumber.uppercased())")
                        Text("Entered at: \(formattedTime(date: entry.entryDateTime))")
                        Text("Contact no.: \(entry.contactNumber)")
                    }
                    .bold()
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        isPresentingCheckoutBill = true
                        slotExited = slotNumber
                        carExited = entry
                    }) {
                        Image(systemName: "delete.right.fill")
                            .foregroundColor(.red)
                    }
                }
            } else {
                Spacer()
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
