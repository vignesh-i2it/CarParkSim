//
//  NumberedSquare.swift
//  CarParkSim
//
//  Created by Vignesh on 02/01/24.
//

import SwiftUI

struct NumberedSquare: View {
    let number: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
            
            Text("\(number)")
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}
