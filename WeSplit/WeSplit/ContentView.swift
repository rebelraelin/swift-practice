//
//  ContentView.swift
//  WeSplit
//
//  Created by Cayla Rae on 8/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeopleIndex = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [15, 18, 20, 25, 0]
    let minNumPeople = 2
    let maxNumPeople = 50
    
    var totalPerPerson: Double {
        let peopleCount = Double(numPeopleIndex + minNumPeople)
        
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numPeopleIndex) {
                        ForEach(minNumPeople..<maxNumPeople, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Bill Info")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
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
