//
//  ContentView.swift
//  VolumeConversion
//
//  Created by Cayla Rae on 9/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: VolumeUnits = VolumeUnits.milliliters
    @State private var outputUnit: VolumeUnits = VolumeUnits.liters
    @State private var value: Double = 1000.0
    @FocusState private var valueIsFocused: Bool
    
    
    enum VolumeUnits: CaseIterable {
        case milliliters, liters, ounces, cups, pints, gallons
        
        func stringValue() -> String {
            switch(self) {
                case .milliliters: return "Milliliters"
                case .liters: return "Liters"
                case .ounces: return "Ounces"
                case .cups: return "Cups"
                case .pints: return "Pints"
                case .gallons: return "Gallons"
            }
        }
    }
    
    var conversionResult: Double {
        var result = value
        
        // convert any input unit to milliliters
        switch(inputUnit) {
            case .milliliters:
                result *= 1
            case .liters:
                result *= 1000
            case .ounces:
                result *= 29.5735
            case .cups:
                result *= 240
            case .pints:
                result *= 473.176
            case .gallons:
                result *= 3785.41
        }
        
        // convert from milliliters to output unit
        switch(outputUnit) {
            case .milliliters:
                result /= 1
            case .liters:
                result /= 1000
            case .ounces:
                result /= 29.5735
            case .cups:
                result /= 240
            case .pints:
                result /= 473.176
            case .gallons:
                result /= 3785.41
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(VolumeUnits.allCases, id: \.self) {
                            Text("\($0.stringValue())")
                        }
                    }
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(VolumeUnits.allCases, id: \.self) {
                            Text("\($0.stringValue())")
                        }
                    }
                } header: {
                    Text("Select Conversion Units")
                }
                
                Section {
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                } header: {
                    Text("Input Value")
                }
                
                Section {
                    Text("\(conversionResult.formatted()) \(outputUnit.stringValue())")
                } header: {
                    Text("Converted Value")
                }
            }
            .navigationTitle("Volume Conversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
