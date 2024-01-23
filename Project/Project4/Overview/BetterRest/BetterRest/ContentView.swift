//
//  ContentView.swift
//  BetterRest
//
//  Created by Ramanan on 19/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        
        //#1 stepper
       //Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        
        
        //#2 Date
       // DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
           // .labelsHidden()
        //DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
            //.labelsHidden()
        
        //Text(Date.now,format: .dateTime.hour().minute())
        
        //Text(Date.now,format: .dateTime.day().month().year())
        
        Text(Date.now.formatted(date: .long, time: .shortened)) //.omitted
        
        
    }
    
    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)
        
        // create a range from those two
        let range = Date.now...tomorrow
    }
    
    
    func trivialExample() {
        //var components = DateComponents()
        //components.hour = 8
        //components.minute = 0
        //let date = Calendar.current.date(from: components) ?? Date.now
        
        let compoenents = Calendar.current.dateComponents([.hour,.minute], from: Date.now)
        let hour = compoenents.hour ?? 0
        let minute = compoenents.minute ?? 0
    
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
