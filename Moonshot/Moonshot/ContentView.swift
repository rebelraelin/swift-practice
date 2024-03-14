//
//  ContentView.swift
//  Moonshot
//
//  Created by Cayla Murdoch on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        Text(String(astronauts.count))
        Text(String(missions.count))
    }
}

#Preview {
    ContentView()
}
