//
//  ContentView.swift
//  EduTainment App
//
//  Created by Mohsin khan on 10/08/2025.
//

import SwiftUI

struct Question{
    let questions : String
    let Answer : Int
}

struct ContentView: View {
    @State private var selectTable = 2
    @State private var selectQuestion = 4
    @State private var selectedQuestions = [4 , 7 , 10]
    
    @State private var questions = [Question]()
    
    @State private var isGameActive = false
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var isGameOver = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.yellow,.red], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            VStack{
                if isGameActive{
                    List{
                        Section{
                            Text("Question : \(currentQuestionIndex + 1) of \(questions.count)")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.blue)
                        }
                        Section{
                            Text("Question : \(questions[currentQuestionIndex].questions)")
                                .font(.title)
                        }
                        Section{
                            TextField("Answer :" , text: $userAnswer)
                                .font(.headline)
                                .keyboardType(.decimalPad)
                        }
                        Section{
                            
                            Button("Submit"){
                                checkAnswer()
                            }
                            
                        }
                        .padding(.horizontal , 140)
                        .listRowInsets(EdgeInsets()) // ✅ No extra padding
                        .listRowBackground(Color.clear)
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    Button("Reset"){
                        score = 0
                        currentQuestionIndex = 0
                        isGameActive = false
                        scoreTitle = ""
                    }
                    .foregroundStyle(.white)
                }else {
                    List{
                        Section("Select Table for QuESTION"){
                            Stepper("table of \(selectTable)" , value: $selectTable , in : 2...10)
                        }
                        Section("How many quqestions you want"){
                            Picker("select No of Question" , selection: $selectQuestion){
                                ForEach(selectedQuestions , id : \.self){
                                    Text("\($0) Questions")
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
        }
            .alert(scoreTitle , isPresented: $isGameOver){
                Button("Play Again"){
                    resetGame()
                }
            }
            
            .navigationTitle("EduTainment App")
            .toolbar{
                Button("Generate"){
                    startGame()
                }
                .foregroundStyle(.blue)
                
            }
        }
    }
    func startGame() {
        questions.removeAll()
        score = 0
        currentQuestionIndex = 0
        
        for _ in 1...selectQuestion {
            let randomNumber = Int.random(in: 1...12)
            let text = "\(selectTable) x \(randomNumber)"
            let answer = selectTable * randomNumber
            questions.append(Question(questions: text, Answer: answer))
        }
        
        isGameActive = true
    }
    
    func checkAnswer() {
        if let answerInt = Int(userAnswer),
           answerInt == questions[currentQuestionIndex].Answer {
            score += 1
        }
        userAnswer = ""
        
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        }
        else {
            scoreTitle = "Game Over! Your score is \(score)/\(questions.count)"
            isGameOver = true
        }
        
    }
    func resetGame() {
        score = 0
        currentQuestionIndex = 0
        questions.removeAll()
        isGameActive = false
    }
}

#Preview {
    ContentView()
}
