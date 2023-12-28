//
//  CarEntry.swift
//  CarParkSim
//
//  Created by Vignesh on 19/12/23.
//

import Foundation

struct CarEntry: Identifiable {
    let id = UUID()
    let registrationNumber: String
    let contactNumber: String
    let entryDateTime: Date
}


