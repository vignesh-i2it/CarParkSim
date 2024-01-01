//
//  ParkingSlot.swift
//  CarParkSim
//
//  Created by Vignesh on 29/12/23.
//

import Foundation

struct ParkingSlot: Identifiable {
    let id = UUID()
    let slotNumber: String
    var carEntry: CarEntry?
}
