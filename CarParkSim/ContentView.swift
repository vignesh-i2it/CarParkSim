//
//  ContentView.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import SwiftUI

struct ContentView: View {
    
    private let allSlots: [String] = Array(1...36).map { String($0) }
    
    @State private var isPresentingAddCarEntrySheet = false
    @State var parkingSlots: [String: CarEntry] = [:]
    @State private var searchText = ""
    @State private var exitDateTime: Date?
    @State private var isPresentingCheckoutBill = false
    @State private var slotExited = ""
    @State private var carExited: CarEntry?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { slotNumber in
                    Section {
                        ParkingSlotRow(
                            slotNumber: slotNumber,
                            carEntry: parkingSlots[slotNumber],
                            parkingSlots: $parkingSlots,
                            isPresentingCheckoutBill: $isPresentingCheckoutBill,
                            slotExited: $slotExited,
                            carExited: $carExited,
                            exitDateTime: $exitDateTime
                        )
                    }
                }
            }
            //.listSectionSpacing(.compact)
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Lot status")
            .toolbar {
                Button(action: {
                    isPresentingAddCarEntrySheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $isPresentingAddCarEntrySheet) {
            AddCarEntrySheet(
                isPresentingAddCarEntrySheet: $isPresentingAddCarEntrySheet,
                allSlots: allSlots,
                parkingSlots: $parkingSlots
            )
        }
        .alert(isPresented: $isPresentingCheckoutBill) {
            Alert(
                title:
                    Text("                                                                  Registration no.: \(carExited?.registrationNumber ?? "")         \n Contact no.:\(carExited?.contactNumber ?? "")                    \n Entered at: \(formattedTime(carExited?.entryDateTime ?? Date())) \n     Exited at: \(formattedTime(exitDateTime ?? Date()))              \n       Duration: \(timeElapsedSinceEntry(carExited?.entryDateTime ?? Date())) \n Fare: \(calculateParkingFees(carExited?.entryDateTime ?? Date(), Date()))  "),
                primaryButton: .default(Text("Checkout")) {
                    checkoutCar()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    var searchResults: [String] {
        let fullSlots: [String] = Array(1...36).map { String($0) }
        if searchText.isEmpty {
            return fullSlots
        } else {
            return fullSlots.filter { parkingSlots[$0]?.registrationNumber == searchText ||
                parkingSlots[$0]?.contactNumber == searchText
            }
        }
    }
    
    func checkoutCar() {
        parkingSlots.removeValue(forKey: slotExited)
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
    
    func calculateParkingFees(_ entryDate: Date, _ exitDate: Date) -> String {
        let elapsedTime = exitDate.timeIntervalSince(entryDate)
        let hours = ceil(Double(elapsedTime) / 3600.0)
        let fee = hours * 50.0
        return String(format: "₹%.2f", fee)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

