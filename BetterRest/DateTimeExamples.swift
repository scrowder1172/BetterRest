//
//  DateTimeExamples.swift
//  BetterRest
//
//  Created by SCOTT CROWDER on 10/18/23.
//

import SwiftUI

struct DateTimeExamples: View {
    var body: some View {
        DatePickerExample()
            .padding(.horizontal)
        ComponentsOfDates()
            .padding(.horizontal)
    }
}

struct DatePickerExample: View {
    
    @State private var wakeUp: Date = Date.now
    
    private var threeMonthsFromNow: Date {
        Calendar.current.date(byAdding: .month, value: 3, to: Date.now) ?? Date.now
    }
    
    var body: some View {
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

struct PrettyButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                    LinearGradient(
                      gradient: Gradient(colors: [Color.black, Color.red]),
                      startPoint: .bottomLeading,
                      endPoint: .topTrailing
                    )
                  )
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

struct ComponentsOfDates: View {
    
    @State private var userSelectedTime: Date = Date.now
    
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(height: 1)
            
            DatePicker("Select a Date & Time:", selection: $userSelectedTime)
            
            Text("Choose Your Printout:")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            HStack {
                Button {
                    printDateComponents()
                } label: {
                    Text("Time Data")
                }
                .modifier(PrettyButton())
                .cornerRadius(15)
                
                Button {
                    printCurrentTime()
                } label: {
                    Text("Time")
                }
                .modifier(PrettyButton())
                .background(.green)
                .cornerRadius(15)
                
                Button {
                    printCurrentDate()
                } label: {
                    Text("Date")
                }
                .modifier(PrettyButton())
                .background(.black)
                .cornerRadius(15)
                
                Button {
                    printUserSelectedDate()
                } label: {
                    Text("User Choice")
                }
                .modifier(PrettyButton())
                .background(.brown)
                .cornerRadius(15)
            }
            
            
            
            
            
            Text(Date.now, format: .dateTime.hour().minute())
            
            Text(Date.now, format: .dateTime.day().month().year())
            
            Text(Date.now.formatted(date: .complete, time: .complete))
            Text(Date.now.formatted(date: .abbreviated, time: .shortened))
            Text(Date.now.formatted(date: .long, time: .standard))
            Text(Date.now.formatted(date: .numeric, time: .omitted))
            Text(Date.now.formatted(date: .omitted, time: .complete))
        }
        
        
    }
    
    func printCurrentTime() {
        let nowDateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = nowDateComponents.hour ?? 0
        let minute = nowDateComponents.minute ?? 0
        print("****")
        print("The current time is: \(hour > 12 ? "\(hour - 12):\(minute) PM" : "\(hour):\(minute) AM")")
        print("A simpler version: \(Date.now.formatted(.dateTime.hour().minute()))")
        print("****")
        print("")
    }
    
    func printCurrentDate() {
        let nowDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
        let day = nowDateComponents.day ?? 0
        let month = nowDateComponents.month ?? 0
        let year = nowDateComponents.year ?? 0
        print("****")
        print("The current month is: \(month)")
        print("The current day is: \(day)")
        print("The current year is: \(year)")
        print("A simpler version: \(Date.now.formatted(.dateTime.month()))")
        print("****")
        print("")
    }
    
    func printDateComponents() {
        var components: DateComponents = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now
        print("Date components: \(date)")
        print("Date.now = \(Date.now)")
        
        
        print("")
        print("********")
    }
    
    func printUserSelectedDate() {
        let userSelectedTimeComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: userSelectedTime)
        let userDay = userSelectedTimeComponents.day ?? 0
        let userMonth = userSelectedTimeComponents.month ?? 0
        let userYear = userSelectedTimeComponents.year ?? 0
        let userHour = userSelectedTimeComponents.hour ?? 0
        let userMinute = userSelectedTimeComponents.minute ?? 0
        
        let weekdayFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter
        }()
        
        let message: String = """
********

The user selected the day: \(userDay)
The user selected the month number: \(userMonth)
The user selected month name: \(userSelectedTime.formatted(.dateTime.month()))
The user selected the year: \(userYear)
The user selected the hour: \(userHour)
The user selected the minute: \(userMinute)
The user selected the day of the week: \(weekdayFormat.string(from: userSelectedTime))
Long Date and Standard Time: \(userSelectedTime.formatted(date: .long, time: .standard))
Date without Time: \(userSelectedTime.formatted(date: .long, time: .omitted))
Time without Date: \(userSelectedTime.formatted(date: .omitted, time: .standard))
********

"""
        print(message)
    }
}



#Preview {
    DateTimeExamples()
}
