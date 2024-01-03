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
        
    @ViewBuilder
    private func rowContent(_ entry: CarEntry?) -> some View {
       
            
        if let entry = carEntry {
            HStack {
                NumberedSquare(number: slotNumber, color: Color.red)
                    .padding(0)
    
            HStack{
                VStack(alignment: .leading) {
                    Text("\(entry.registrationNumber.uppercased())").bold()
                    Text("Entry       -  \(formattedTime(date: entry.entryDateTime))").bold().foregroundColor(.gray)
                    Text("Contact  -  \(entry.contactNumber)").bold().foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                Button(action: {
                    isPresentingCheckoutBill = true
                    slotExited = slotNumber
                    carExited = entry
                }) {
                    Image(systemName: "delete.right.fill")
                        .foregroundColor(.red)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
            }
        }
        } else {
            ZStack(alignment: .leading){
                HStack{
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("")
                            .foregroundColor(.clear)
                        Text("Available")
                            .foregroundColor(.green)
                        Text("")
                            .foregroundColor(.clear)
                    }
                    Spacer()
                }
                
                NumberedSquare(number: slotNumber, color: Color.green)
                    .padding(EdgeInsets(top: 0, leading: -8, bottom: 0, trailing: 0))
            }
        }
    }

    func formattedTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}
