//
//  ContentView.swift
//  P1CL
//
//  Created by Ramanan on 12/10/22.
//

extension Double {
    var celsiusToFahrenheit: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.celsius)
        return value.converted(to: UnitTemperature.fahrenheit)
    }

    var celsiusToKelvin: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.celsius)
        return value.converted(to: UnitTemperature.kelvin)
    }

    var fahrenheitToCelsius: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.fahrenheit)
        return value.converted(to: UnitTemperature.celsius)
    }

    var fahrenheitToKelvin: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.fahrenheit)
        return value.converted(to: UnitTemperature.kelvin)
    }

    var kelvinToCelsius: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.kelvin)
        return value.converted(to: UnitTemperature.celsius)
    }

    var kelvinToFahrenheit: Measurement<UnitTemperature> {
        let value = Measurement(value: self, unit: UnitTemperature.kelvin)
        return value.converted(to: UnitTemperature.fahrenheit)
    }
}

import SwiftUI

struct ContentView: View {
    @State private var tempValue = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var keyboardDismiss: Bool
   
    var tempUnits = ["Celsius","Fahrenheit","Kelvin"]
        
    var conversionValue: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        if inputUnit == "Celsius" && outputUnit == "Fahrenheit" {
            return formatter.string(from: tempValue.celsiusToFahrenheit)
        } else if inputUnit == "Celsius" && outputUnit == "Kelvin" {
            return formatter.string(from: tempValue.celsiusToKelvin)
        } else if inputUnit == "Fahrenheit" && outputUnit == "Celsius" {
            return formatter.string(from: tempValue.fahrenheitToCelsius)
        } else if inputUnit == "Fahrenheit" && outputUnit == "Kelvin" {
            return formatter.string(from: tempValue.fahrenheitToKelvin)
        } else if inputUnit == "Kelvin" && outputUnit == "Celsius" {
            return formatter.string(from: tempValue.kelvinToCelsius)
        } else if inputUnit == "Kelvin" && outputUnit == "Fahrenheit" {
            return formatter.string(from: tempValue.kelvinToFahrenheit)
        } else {
            switch inputUnit {
            case "Kelvin":
                let value = Measurement(value: tempValue, unit: UnitTemperature.kelvin).converted(to: UnitTemperature.kelvin)
                 return formatter.string(from: value)
            case "Celsius":
                let value = Measurement(value: tempValue, unit: UnitTemperature.celsius).converted(to: UnitTemperature.celsius)
                 return formatter.string(from: value)
            case "Fahrenheit":
                let value = Measurement(value: tempValue, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature.fahrenheit)
                return formatter.string(from: value)
            default:
                let value = Measurement(value: tempValue, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature.fahrenheit)
                return formatter.string(from: value)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Enter Input Unit", selection: $inputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert From")
                }
                
                Section {
                    TextField("Enter the value", value: $tempValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardDismiss)
                } header: {
                    Text("Enter the value")
                }
                
                Section {
                 Picker("Enter Output Unit", selection: $outputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    Text(conversionValue)
                } header: {
                    Text("Output")
                }
                .navigationTitle("Temp Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("OK") {
                            keyboardDismiss = false
                        }
                    }
                }//
            }
        }//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}



/*
var conversionValue: Double {
    if inputUnit == "Celsius" && outputUnit == "Fahrenheit" {
        //return tempValue.celsiusToFahrenheit
        return tempValue * 9/5 + 32
    } else if inputUnit == "Celsius" && outputUnit == "Kelvin" {
        //return tempValue.celsiusToKelvin
        return tempValue + 273.15
    } else if inputUnit == "Fahrenheit" && outputUnit == "Celsius" {
        //return tempValue.fahrenheitToCelsius
        return (tempValue - 32) * 5/9
    } else if inputUnit == "Fahrenheit" && outputUnit == "Kelvin" {
        //return tempValue.fahrenheitToKelvin
        return (tempValue + 459.67) * 5/9
    } else if inputUnit == "Kelvin" && outputUnit == "Celsius" {
        //return tempValue.kelvinToCelsius
        return tempValue - 273.15
    } else if inputUnit == "Kelvin" && outputUnit == "Fahrenheit" {
        //return tempValue.kelvinToFahrenheit
        return tempValue * 9/5 - 459.67
    } else {
        return tempValue
        //return Measurement(value: tempValue, unit: .kelvin)
    }
}
*/
