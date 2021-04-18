//
//  ContentView.swift
//  Edutainment
//
//  Created by sanmi_personal on 18/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var selectedMutiplicationTable : Int = 5
    @State private var numberOfQuestions: Int = 5
    @State private var questions : Array<Question> = []
    @State private var currentQuestionIndex: Int = 1
    @State private var userInputtedAnswer: String = ""
    @State private var userScore = 0
    @State private var isGameComplete = false
    @State private var gameCompleteMessage = ""
    
    var body: some View {
        if isGameActive {
            Group {
                VStack {
                    Text("User Score: \(userScore)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                    Text("\(questions[currentQuestionIndex].data)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                    TextField("Enter your answer", text: $userInputtedAnswer)
                        .padding()
                    Spacer()
                    Button("Enter") {
                        checkAnswer(userAnswer: Int(userInputtedAnswer) ?? 0, answer: questions[currentQuestionIndex].answer)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .alert(isPresented: $isGameComplete) {
                        Alert(title: Text(gameCompleteMessage), message: Text("Restart game"), primaryButton: .destructive(Text("Okay")) {
                            isGameActive = false
                            userInputtedAnswer = ""
                            userScore = 0
                            gameCompleteMessage = ""
                            currentQuestionIndex = 1
                        }, secondaryButton: .cancel())
                    }
                }
            }
        } else {
            Group {
                VStack {
                    StepperView(title: "Multiplication Table", selectedOption: $selectedMutiplicationTable, range: 1...12)
                        .padding()
                    
                    StepperView(title: "Number of questions", selectedOption: $numberOfQuestions, range: 5...20)
                        .padding()
                    Spacer()
                    Button("Start game") {
                        generateQuestions()
                        isGameActive.toggle()
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.red)
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        for question in 1...numberOfQuestions {
            let question = Question(data: "\(selectedMutiplicationTable) X \(question)", answer: selectedMutiplicationTable * question)
            questions.append(question)
        }
    }
    
    func checkAnswer(userAnswer: Int, answer: Int) {
        if userAnswer == answer {
            userScore += 1
        }
        userInputtedAnswer = ""
        if currentQuestionIndex < numberOfQuestions - 1 {
            currentQuestionIndex += 1
        } else {
            gameCompleteMessage = "Your score is \(userScore)"
            isGameComplete = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
