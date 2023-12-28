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
    @State  var parkingSlots: [String: CarEntry] = [:]
    @State private var searchText = ""
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { slotNumber in
                    Section {
                        ParkingSlotRow(
                            slotNumber: slotNumber,
                            carEntry: parkingSlots[slotNumber],
                            parkingSlots: $parkingSlots
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
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return allSlots
        } else {
            return allSlots.filter { parkingSlots[$0]?.registrationNumber == searchText ||
                parkingSlots[$0]?.contactNumber == searchText
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

