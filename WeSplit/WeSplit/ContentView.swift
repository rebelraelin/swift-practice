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
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    let tipPercentages = [15, 18, 20, 25, 0]
    let minNumPeople = 2
    let maxNumPeople = 50
    
    var totalAmount: Double {
        let tipValue = checkAmount * Double(tipPercentage) / 100
        
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        totalAmount / Double(numPeopleIndex + minNumPeople)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
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
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Total Per Person")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: currencyCode))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total Amount")
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
