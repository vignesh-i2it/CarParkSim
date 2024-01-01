//
//  ContentView.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var parkingSlots: [ParkingSlot] = (1...36).map { ParkingSlot(slotNumber: "\($0)", carEntry: nil) }
    
    @State private var searchText = ""
    @State private var isPresentingAddCarEntrySheet = false
    @State private var isPresentingCheckoutBill = false
    @State private var slotExited = ""
    @State private var carExited: CarEntry?
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottomTrailing){
                
                List{
                    ForEach(searchResults) { parkingSlot in
                        Section {
                            ParkingSlotRow(
                                slotNumber: parkingSlot.slotNumber,
                                carEntry: parkingSlot.carEntry,
                                parkingSlots: $parkingSlots,
                                isPresentingCheckoutBill: $isPresentingCheckoutBill,
                                slotExited: $slotExited,
                                carExited: $carExited
                            )
                        }
                    }
                }
                //.listSectionSpacing(.compact)
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Lot status")
                .toolbar {
                    Button(action: {
                        //
                    }) {
                        //Image(systemName: "plus")
                        Text("Add slots")
                            .bold()
                    }
                }
                
                Button {
                    isPresentingAddCarEntrySheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding()
            }
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $isPresentingAddCarEntrySheet) {
            AddCarEntrySheet(
                isPresentingAddCarEntrySheet: $isPresentingAddCarEntrySheet,
                parkingSlots: $parkingSlots
            )
        }
        .alert(isPresented: $isPresentingCheckoutBill) {
            Alert(
                title:
                    Text("                                                                  Registration no.: \(carExited?.registrationNumber ?? "")         \n   Contact no.:\(carExited?.contactNumber ?? "")                    \n   Entered at: \(formattedTime(carExited?.entryDateTime ?? Date())) \n    Exited at: \(formattedTime(Date()))                              \n          Duration: \(timeElapsed(carExited?.entryDateTime ?? Date()))     \n     Fare: \(calculateParkingFees(carExited?.entryDateTime ?? Date(), Date()))  "),
                primaryButton: .default(Text("Checkout")) {
                    checkoutCar()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    var searchResults: [ParkingSlot] {
        if searchText.isEmpty {
            return parkingSlots
        } else {
            return parkingSlots.filter {
                $0.carEntry?.registrationNumber == searchText ||
                $0.carEntry?.contactNumber == searchText
            }
        }
    }
    
    func checkoutCar() {
        if let index = parkingSlots.firstIndex(where: { $0.slotNumber == slotExited }) {
            parkingSlots[index].carEntry = nil
        }
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func timeElapsed(_ entryDate: Date) -> String {
        let elapsedTime = Date().timeIntervalSince(entryDate)
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
