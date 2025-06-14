//
//  ContentView.swift
//  Edutainment
//
//  Created by shalinth adithyan on 14/06/25.
//
import SwiftUI

struct Question {
    let text : String
    let answer : Int
}

struct ContentView : View {
    enum GameState {
        case settings
        case playing
        case result
    }
    @State private var gameState : GameState = .settings
    @State private var uptoTable = 5
    @State private var numberOfQuestions : Int = 10
    @State private var currentQuestionIndex = 0
    @State private var questions : [Question] = []
    
    @State private var userAnswer = " "
    @State private var score = 0
    var body : some View {
            VStack(spacing: 20) {
                if gameState == .settings {
                    Text("Multiplication Game ")
                        .font(.largeTitle)
                        .bold(true)
                    Stepper("Practice table upto : \(uptoTable)" , value:$uptoTable ,in:2...20 )
                        .font(.headline)
                    
                    Picker("Number of questions ", selection: $numberOfQuestions){
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("15").tag(15)
                        Text("20").tag(20)
                    }
                    .pickerStyle(.segmented)
                    
                    Button("Start Game"){
                        startGame()
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }
       
                else if gameState == .playing
                {
                    Text("Question : \(currentQuestionIndex + 1)/\(numberOfQuestions)")
                        .font(.headline)
                    
                    Text(questions[currentQuestionIndex].text)
                        .font(.largeTitle)
                        .bold(true)
                    TextField("Your Answer ", text : $userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 180, height: 55)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .font(.system(size: 20, design: .rounded))
                    
                    
                    Button("Submit"){
                        checkAnswer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    Button {
                        resetGame()
                    } label: {
                        Label("Restart Game", systemImage: "arrow.counterclockwise.circle.fill")
                    }
                    .foregroundColor(.red)
                    .padding()
                    .clipShape(Capsule())
                }
                        else if gameState == .result {
                            Text("Game over !")
                                .font(.largeTitle)
                                .bold()
                            
                            Text("Your score : \(score)/\(numberOfQuestions)")
                                .font(.title2)
                            
                            Button("Play again"){
                                resetGame()
                            }
                            .padding()
                            .background(Color.primary)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                            
                        }
                        
                    }
                
                
                
            }
            func startGame(){
                score = 0
                currentQuestionIndex = 0
                userAnswer = ""
                questions = generateQuestions()
                gameState = .playing
            }
            
            func generateQuestions() -> [Question] {
                var generated = [Question]()
                let range = 2...uptoTable
                while generated.count < numberOfQuestions{
                    
                    let a = Int.random(in: range)
                    let b = Int.random(in: 1...12)
                    let text = "\(a) x \(b)"
                    let answer = a * b
                    generated.append(Question(text : text , answer : answer))
                    
                }
                return generated.shuffled()
            }
            func checkAnswer()  {
                guard let answerInt = Int(userAnswer) else { return }
                if answerInt == questions[currentQuestionIndex].answer {
                    score += 1
                }
                userAnswer = ""
                
                if currentQuestionIndex + 1 < questions.count  {
                    currentQuestionIndex += 1
                    
                }else {
                    gameState = .result
                }
            }
            func resetGame(){
                gameState = .settings
            }
            func restartGame(){
                withAnimation{
                    userAnswer.removeAll()
                    gameState = .settings
                    
                }
            }
        
}

#Preview {
    ContentView()
}
