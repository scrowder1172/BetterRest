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
    
    private var threeMonthsFromNow: Date {
        Calendar.current.date(byAdding: .month, value: 3, to: Date.now) ?? Date.now
    }
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        
        DatePicker("Please enter a date", selection: $wakeUp, in: ...Date.now)
            .labelsHidden()
        
        DatePicker("Date only selection", selection: $wakeUp, in: ...Date.now,
                   displayedComponents: .date)
        
        DatePicker("Time only selection", selection: $wakeUp, in: ...Date.now,
                   displayedComponents: .hourAndMinute)
        
        DatePicker("Dates in the past only", selection: $wakeUp, in: ...Date.now,
                   displayedComponents: .date)
        
        DatePicker("Dates for next 3 months", selection: $wakeUp, in: Date.now...threeMonthsFromNow,
            displayedComponents: .date)
        
    }
}

#Preview {
    ContentView()
}
