//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cayla Rae on 9/10/23.
//

import SwiftUI

struct MoveImageMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .foregroundColor(.black)
            .font(.system(size: 70))
            .padding(5)
    }
}

extension View {
    func imageStyle() -> some View {
        modifier(MoveImageMod())
    }
}

struct MoveImage: View {
    var move: String
    
    var body: some View {
        if move == "Rock" {
            Image(systemName: "mountain.2.circle.fill")
                .imageStyle()
        } else if move == "Paper" {
            Image(systemName: "newspaper.circle.fill")
                .imageStyle()
        } else {
            Image(systemName: "scissors.circle.fill")
                .imageStyle()
        }
    }
}

struct ContentView: View {
    @State private var appMove = Int.random(in: 0...2)
    @State private var playerMove = 0
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var roundCounter = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var gameOver = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.89, green: 0.88, blue: 0.78), location: 0.3),
                .init(color: Color(red: 0.59, green: 0.55, blue: 0.34), location: 0.3),
            ], center: .bottom, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors Showdown")
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 0.89, green: 0.88, blue: 0.78))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(Color(red: 0.89, green: 0.88, blue: 0.78))
                
                Spacer()
                
                VStack {
                    Text("App move:")
                    MoveImage(move: moves[appMove])
                    Text(moves[appMove])
                }
                .frame(minWidth: 200, minHeight: 200)
                .background(Color(red: 0.89, green: 0.88, blue: 0.78))
                .cornerRadius(20)
                
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                VStack {
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
                }
                
                Group {
                    Spacer()
                    Spacer()
                }
            }
        }
        .alert("\(scoreTitle)", isPresented: $showingScore) {
            Button("Continue", action: newRound)
        } message: {
            Text("Round: \(roundCounter), Score: \(score)")
        }
        .alert("\(scoreTitle) GAME OVER!", isPresented: $gameOver) {
            Button("Restart", action: newGame)
        } message: {
            Text("Your final score is \(score)/10")
        }
    }
    
    func moveTapped(_ move: String) {
        scoreTitle = "Correct!"
        
        if shouldWin {
            if moves[appMove] == "Rock" && move == "Paper" {
                score += 1
            } else if moves[appMove] == "Paper" && move == "Scissors" {
                score += 1
            } else if moves[appMove] == "Scissors" && move == "Rock" {
                score += 1
            } else {
                if score > 0 { score -= 1 }
                scoreTitle = "Incorrect!"
            }
        } else {
            if moves[appMove] == "Rock" && move == "Scissors" {
                score += 1
            } else if moves[appMove] == "Paper" && move == "Rock" {
                score += 1
            } else if moves[appMove] == "Scissors" && move == "Paper" {
                score += 1
            } else {
                if score > 0 { score -= 1 }
                scoreTitle = "Incorrect!"
            }
        }
        
        roundCounter += 1
        
        if roundCounter == 10 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func newRound() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func newGame() {
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        score = 0
        roundCounter = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
