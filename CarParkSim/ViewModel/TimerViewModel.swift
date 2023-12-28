//
//  TimerViewModel.swift
//  CarParkSim
//
//  Created by Vignesh on 26/12/23.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    var referenceTime: Date?

    private var timer: Timer?

    func startTimer(withReferenceTime referenceTime: Date) {
        self.referenceTime = referenceTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateElapsedTime()
        }
    }

    private func updateElapsedTime() {
        guard let referenceTime = referenceTime else { return }
        let currentTime = Date()
        elapsedTime = currentTime.timeIntervalSince(referenceTime)
    }

    deinit {
        timer?.invalidate()
    }
}

struct TimerView: View {
    @ObservedObject var timerViewModel = TimerViewModel()

    init(referenceTime: Date) {
        timerViewModel.startTimer(withReferenceTime: referenceTime)
    }

    var body: some View {
        VStack {
            Text("Elapsed Time:")
                .font(.headline)
            
            Text(timeString(from: timerViewModel.elapsedTime))
                .font(.largeTitle)
        }
    }

    func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct ContentView: View {
    var body: some View {
        TimerView(referenceTime: Date())
    }
}

// Usage
ContentView()

