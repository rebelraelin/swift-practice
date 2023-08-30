//
//  ContentView.swift
//  WeSplit
//
//  Created by Cayla Rae on 8/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Cayla", "Shadow", "Luna"]
    @State private var selectedStudent = "Cayla"
    
    var body: some View {
        NavigationView {
            Form {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Group {
                    Text("yoyoyo!")
                    Text("yoyoyo!")
                    Text("yoyoyo!")
                }
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                }
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Hello World")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
