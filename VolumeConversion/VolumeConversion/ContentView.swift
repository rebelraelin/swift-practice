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
    @State private var value: Double = 0.0
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
        let inputMeasurement: Measurement<UnitVolume>
        let outputMeasurement: Measurement<UnitVolume>
        
        switch(inputUnit) {
        case .milliliters:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.milliliters)
        case .liters:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.liters)
        case .ounces:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.fluidOunces)
        case .cups:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.cups)
        case .pints:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.pints)
        case .gallons:
            inputMeasurement = Measurement(value: value, unit: UnitVolume.gallons)
        }
        
        switch(outputUnit) {
        case .milliliters:
            outputMeasurement = inputMeasurement.converted(to: .milliliters)
        case .liters:
            outputMeasurement = inputMeasurement.converted(to: .liters)
        case .ounces:
            outputMeasurement = inputMeasurement.converted(to: .fluidOunces)
        case .cups:
            outputMeasurement = inputMeasurement.converted(to: .cups)
        case .pints:
            outputMeasurement = inputMeasurement.converted(to: .pints)
        case .gallons:
            outputMeasurement = inputMeasurement.converted(to: .gallons)
        }
        
        return outputMeasurement.value
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
                    Text(conversionResult.formatted())
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
