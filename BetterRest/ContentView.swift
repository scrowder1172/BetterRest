//
//  ContentView.swift
//  BetterRest
//
//  Created by SCOTT CROWDER on 10/18/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp: Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeCupIndex: Int = 0
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var wakeUpMessage: String {
        
        var msg: String = "You should wake up now"
        
        do {
            let actualCoffeeAmount: Int = coffeeCupIndex + 1
            
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(actualCoffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            msg = "Your ideal bedtime is...\n\(sleepTime.formatted(date: .omitted, time: .shortened))"
            print("Wake up: \(wakeUp)")
            print("actualSleep: \(prediction.actualSleep)")
            print("Cups of Coffee: \(actualCoffeeAmount)")
        } catch {
            msg = "ERROR...Sorry, there was a problem calculating your bedtime."
        }
        
        return msg
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack (alignment: .leading, spacing: 0) {
                    
                    DatePicker("Select wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    
                }
                
                VStack (alignment: .leading, spacing: 0){
                    Picker("Cups of coffee per day", selection: $coffeeCupIndex) {
                        ForEach(0..<20) {
                            Text("^[\($0 + 1) cups](inflect: true)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much sleep do you want?") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
            
            VStack {
                Text(wakeUpMessage)
                    .multilineTextAlignment(.center)
            }
            .font(.system(size: 35).bold())
            
            Spacer()
        }
    }
    
    func calculateBedtime() {
        do {
            let actualCoffeeAmount: Int = coffeeCupIndex + 1
            
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(actualCoffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            print("Wake up: \(wakeUp)")
            print("actualSleep: \(prediction.actualSleep)")
            print("Cups of Coffee: \(actualCoffeeAmount)")
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
    
    
}

#Preview {
    ContentView()
}
