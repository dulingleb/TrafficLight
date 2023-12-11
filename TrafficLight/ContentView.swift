//
//  ContentView.swift
//  TrafficLight
//
//  Created by Dulin Gleb on 11.12.23..
//

import SwiftUI

enum TrafficLightState {
    case red
    case redYellow
    case green
    case yellow
}

struct ContentView: View {
    @State var redTurnedOn: Bool = true
    @State var yelloTurnedOn: Bool = false
    @State var greenTurnedOn: Bool = false
    
    @State var currentStateLight: TrafficLightState = .red
    
    @State var isTimerRunning: Bool = false
    @State var timer: Timer? = nil
    
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 150, height: 400)
                    .cornerRadius(15)
                
                VStack {
                    Circle()
                        .fill(redTurnedOn ? .red : .red.opacity(0.5))
                        .frame(width: 120)
                    
                    Circle()
                        .fill(yelloTurnedOn ? .yellow : .yellow.opacity(0.5))
                        .frame(width: 120)
                    
                    Circle()
                        .fill(greenTurnedOn ? .green : .green.opacity(0.5))
                        .frame(width: 120)
                }
            }
            
            HStack {
                Button(action: changeColor) {
                    Text("Next")
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    isTimerRunning ? stopTimer() : startTimer()
                    isTimerRunning.toggle()
                }) {
                    Text("Auto")
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
        .padding()
    }
    
    func changeColor() {
        switch currentStateLight {
        case .red:
            changeState(state: .redYellow, red: true, yellow: true, green: false)
        case .redYellow:
            changeState(state: .green, red: false, yellow: false, green: true)
        case .green:
            changeState(state: .yellow, red: false, yellow: true, green: false)
        case .yellow:
            changeState(state: .red, red: true, yellow: false, green: false)
        }
    }
    
    private func changeState(state: TrafficLightState, red: Bool, yellow: Bool, green: Bool) {
        currentStateLight = state
        redTurnedOn = red
        yelloTurnedOn = yellow
        greenTurnedOn = green
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        stopTimer()
        guard self.timer == nil else { return }
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            changeColor()
        })

    }
}

#Preview {
    ContentView()
}
