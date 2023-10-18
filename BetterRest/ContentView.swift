//
//  ContentView.swift
//  BetterRest
//
//  Created by SCOTT CROWDER on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount: Double = 8.0
    
    @State private var wakeUp: Date = Date.now
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        
        DatePicker("Please enter a date", selection: $wakeUp, in: ...Date.now)
            .labelsHidden()
        Button {
            //
        } label: {
            Text("Time Data")
        }
        .modifier(PrettyButton())
        .background(.cyan)
    }
    
    
}

#Preview {
    ContentView()
}
