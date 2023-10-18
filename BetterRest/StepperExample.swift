//
//  StepperExample.swift
//  BetterRest
//
//  Created by SCOTT CROWDER on 10/18/23.
//

import SwiftUI

struct StepperExample: View {
    @State private var sleepAmount: Double = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)        
    }
}

#Preview {
    StepperExample()
}
