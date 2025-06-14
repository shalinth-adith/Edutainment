//
//  ContentView.swift
//  Edutainment
//
//  Created by shalinth adithyan on 14/06/25.
//
import SwiftUI

struct ContentView : View {
    enum GameState {
        case settings
        case playing
        case result
    }
    @State private var gameState : GameState = .settings
    @State private var uptoTable = 5
    @State private var numberOfQuestions : Int = 10
    
    var body : some View {
        VStack {
            Text("Multiplication Game ")
                .font(.largeTitle)
                .bold(true)
            Stepper("Practice table upto : \(uptoTable)" , value:$uptoTable ,in:2...20 )
            
            Picker("Number of questions ", selection: $numberOfQuestions){
                Text("5").tag(5)
                Text("10").tag(10)
                Text("15").tag(15)
                Text("20").tag(20)
            }
            .pickerStyle(.segmented)
            
            Button("Start"){
                startGame()
                
            }
        }
    
    }
    func startGame(){
        
    }
}

#Preview {
    ContentView()
}
