//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cayla Rae on 9/10/23.
//

import SwiftUI

struct MoveImage: View {
    var move: String
    
    var body: some View {
        if move == "Rock" {
            Image(systemName: "mountain.2.circle.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.system(size: 50))
        } else if move == "Paper" {
            Image(systemName: "newspaper.circle.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.system(size: 50))
        } else {
            Image(systemName: "scissors.circle.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.system(size: 50))
        }
    }
}

struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"]
    @State private var appMove = Int.random(in: 0...2)
    @State private var playerMove = 0
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var roundCounter = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Score: \(score)")
                .font(.title)
            
            Spacer()
            
            HStack {
                MoveImage(move: moves[appMove])
                Text(moves[appMove])
            }
            
            Spacer()
            
            if shouldWin {
                Text("Make the WINNING move:")
            } else {
                Text("Make the LOSING move:")
            }
            HStack {
                ForEach(0..<3) { move in
                    Button {
                        moveTapped(moves[move])
                    } label: {
                        MoveImage(move: moves[move])
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    func moveTapped(_ move: String) {
        if shouldWin {
            if moves[appMove] == "Rock" && move == "Paper" {
                score += 1
            } else if moves[appMove] == "Paper" && move == "Scissors" {
                score += 1
            } else if moves[appMove] == "Scissors" && move == "Rock" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if moves[appMove] == "Rock" && move == "Scissors" {
                score += 1
            } else if moves[appMove] == "Paper" && move == "Rock" {
                score += 1
            } else if moves[appMove] == "Scissors" && move == "Paper" {
                score += 1
            } else {
                score -= 1
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
