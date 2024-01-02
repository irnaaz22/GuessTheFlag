//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tajdar unnisa Begum on 25/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France","Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain",
                                    "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCounter = 1
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        
                    }
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: 350)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 25))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        
        
        .alert(scoreTitle, isPresented: $showingScore)  {
            if questionCounter != 8 {
                Button("Continue", action: askQuestion)
            }else {
                Button("Restart", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Your score is \(userScore)")
            } else {
                Text("Your game ended with a score of \(userScore). Restart the game")
            }
        }
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct! Thats the flag of \(countries[number])"
            userScore += 1
        } else {
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
            userScore -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
        
    }
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 1
    
    }
}
#Preview {
    ContentView()
}
