//
//  ContentView.swift
//  Project4-6
//
//  Created by Ramanan on 08/11/22.
//

import SwiftUI

struct CustomOpenButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            //.font(.subheadline.weight(.medium))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customOpenButtonStyle() -> some View {
        modifier(CustomOpenButtonModifier())
    }
}

struct CustomButton2Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .font(.subheadline.weight(.medium))
            .foregroundColor(.white)
            .background(LinearGradient(colors: [.pink,.gray], startPoint: .leading, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButton2Style() -> some View {
        modifier(CustomButton2Modifier())
    }
}

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .font(.title3.weight(.medium))
            .foregroundColor(.white)
            .background(LinearGradient(colors: [.indigo,.gray], startPoint: .leading, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButtonStyle() -> some View {
        modifier(CustomButtonModifier())
    }
}

struct ContentView: View {
    @State private var ViewOneFlag = true //true
    @State private var ViewTwoFlag = false //false
    @State private var ViewThreeFlag = false //false
    
    @State private var tableSelected = 2
    @State private var questionSelected = 0
    @State private var difficultySelected = 0
    var level = ["Easy", "Medium", "Hard"]
    @State private var questionSelectionFlag = false
    @State private var difficultySelectionFlag = false
    @State private var showingAlert = false
    
    @State private var questionArray = [String]()// ["2 * 44", "2 * 37", "2 * 30", "2 * 41", "2 * 33", "2 * 34", "2 * 39", "2 * 41", "2 * 32", "2 * 33"]
    @State private var answerArray = [String]() // ["88", "74", "60", "82", "66", "68", "78", "82", "64", "66"]
    
    @State private var checkAnswer = ""
    @State private var score = 0
    @State private var questionCount = 0
    @State private var gameEndAlert = false
    @State private var wrongAnswerView = false
    
    @State private var buttonStateCheck = true
    @State private var finalAnswer = ""
    @State private var textFieldDisabled = false
    @State private var animationAmount = 0.0
    
    @FocusState private var dismissKeyboard: Bool
    
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile",
    "dog", "duck", "elephant", "frog", "giraffe", "goat",
    "gorilla", "hippo", "horse", "monkey", "moose", "narwhal",
    "owl", "panda", "parrot", "penguin", "pig", "rabbit",
    "rhino", "sloth", "walrus", "whale", "zebra"].shuffled()
    
    var animalView: some View {
        Image(animals[Int.random(in: 0...animals.count - 1)])
            .onAppear {
                withAnimation(.easeIn.speed(0.1).repeatForever(autoreverses: true)) {
                    print("helo")
                    animationAmount += 360
                }
            }
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.2, y: 0.2, z: -0.5))
            .onTapGesture {
                print("askld")
                withAnimation {
                    animals.shuffle()
                }
            }
    }
    
    var body: some View {
        
        
        if ViewOneFlag {
        
            ZStack {
                
                RadialGradient(stops: [
                    .init(color: .blue.opacity(0.5), location: 0),
                    .init(color: .black.opacity(0.5), location: 0)
                ], center: .top, startRadius: 260, endRadius: 400)
                    
            
                VStack(alignment: .center, spacing: 40) {
                    
                    Image(animals[Int.random(in: 0...animals.count - 1)])
                        .onAppear {
                            withAnimation(.interpolatingSpring(stiffness: 3, damping: 0.3).repeatForever(autoreverses: true)) {
                                print("helo")
                                animationAmount += 360
                            }
                        }
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 0.5))
                        .onTapGesture {
                            print("askld")
                            withAnimation {
                                animals.shuffle()
                            }
                        }
                        
                    Text("Select a table to train")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(LinearGradient(colors: [.brown,.blue], startPoint: .leading, endPoint: .trailing))
                        
                    
                    VStack(alignment: .center, spacing: 30) {
                        HStack(alignment: .center, spacing: 25) {
                            ForEach(2..<5) { num in
                                Button("Table \(num)") {
                                    tableSelection(num)
                                }
                                .customButtonStyle()
                            }
                        }
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(5..<8) { num in
                                Button("Table \(num)") {
                                    tableSelection(num)
                                }
                                .customButtonStyle()
                            }
                        }
                        HStack(alignment: .center, spacing: 25) {
                            ForEach(8..<11) { num in
                                Button("Table \(num)") {
                                    tableSelection(num)
                                }
                                .customButtonStyle()
                            }
                        }
                        HStack(alignment: .center, spacing: 25) {
                            ForEach(11..<13) { num in
                                Button("Table \(num)") {
                                    tableSelection(num)
                                }
                                .customButtonStyle()
                            }
                        }
                    }
                    
                }
            }
        }
        
        
        if ViewTwoFlag {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.9),.white.opacity(0.3), .gray.opacity(0.4)] ), startPoint: .top, endPoint: .bottom)
                    .opacity(0.5)
                
              
                VStack {
                    Spacer()
                        animalView
                
                    Section {
                        Spacer()
                        Spacer()
                        Text("Select No Of Questions")
                            .font(.title2.weight(.bold))
                        .foregroundStyle(LinearGradient(colors: [.white,.yellow], startPoint: .leading, endPoint: .trailing))
                        
                        VStack(alignment: .center, spacing: 10) {
                            HStack(alignment: .center, spacing: 10) {
                                ForEach(1..<5) { num in
                                    Button("\(num * 5)") {
                                        questionSelected = (num * 5)
                                        questionSelectionFlag = true
                                    }
                                    .padding(15)
                                    .font(.title.weight(.bold))
                                    .foregroundColor(.white)
                                    .background(questionSelected == num * 5 ? LinearGradient(colors: [.green.opacity(0.8),.black], startPoint: .leading, endPoint: .bottomTrailing) : LinearGradient(colors: [.pink.opacity(0.8),.black], startPoint: .leading, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                           
                        }//Vstack

                    }//section
                    
                    
                    Section {
                        Spacer()
                        VStack {
                            Text("Select Your Difficulty Level")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(LinearGradient(colors: [.white,.orange], startPoint: .leading, endPoint: .trailing))
                            
                            HStack(alignment: .center, spacing: 20) {
                                ForEach(0..<level.count) { num in
                                    Button("\(level[num])") {
                                        difficultySelected = num
                                        difficultySelectionFlag = true
                                    }
                                    .padding(15)
                                    .font(.title3.weight(.bold))
                                    .foregroundColor(.white)
                                    .background(difficultySelectionFlag && difficultySelected == num ? LinearGradient(colors: [.green.opacity(0.8),.black], startPoint: .leading, endPoint: .bottomTrailing) : LinearGradient(colors: [.blue.opacity(0.8),.black], startPoint: .leading, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                }
                            }
                        }//Vstack
                        
                    }//section
                    Spacer()
                    VStack {
                        VStack(spacing: 20) {
                            Button("Want to change the table?") {
                                changeTable()
                            }
                            .customOpenButtonStyle()
                            .padding(3)
                            .font(.title3.weight(.medium))
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.black,.orange], startPoint: .leading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Button("Let's Play") {
                                play()
                            }
                            .customOpenButtonStyle()
                            .padding(10)
                            .font(.title2.weight(.heavy))
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.black,.purple], startPoint: .leading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text("Select the required items")
            }

           
        }
        
        if ViewThreeFlag {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.9),.white.opacity(0.3), .cyan.opacity(0.4)] ), startPoint: .top, endPoint: .bottom)
                    .opacity(0.5)
                
                
                VStack(alignment: .center, spacing: 30) {
                    Spacer()
                    animalView
                    Spacer()
                   
                    VStack(spacing:10) {
                        Text("Solve : \(questionArray[questionCount])")
                            .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(LinearGradient(colors: [.brown,.blue], startPoint: .leading, endPoint: .trailing))
                        
                        TextField("Enter the answer", text: $checkAnswer)
                            .padding(10)
                            .border(.gray, width: 0.4)
                            .background(LinearGradient(colors: [.gray,.blue.opacity(0.6)], startPoint: .bottomLeading, endPoint: .bottomTrailing))
                            .disabled(textFieldDisabled)
                            .padding()
                            .keyboardType(.decimalPad)
                            .focused($dismissKeyboard)
                        
                    
                        if finalAnswer == answerArray[questionCount] {
                            Text("Correct Answer")
                                .font(.title2.weight(.bold))
                            .foregroundStyle(LinearGradient(colors: [.brown,.blue], startPoint: .leading, endPoint: .trailing))
                        } else if wrongAnswerView {
                            Text("Wrong. Correct Answer = \(answerArray[questionCount])")
                                .font(.title2.weight(.bold))
                            .foregroundStyle(LinearGradient(colors: [.brown,.blue], startPoint: .leading, endPoint: .trailing))
                        }
                        
                        
                        Button(buttonStateCheck == true ? "Check" : "Next") {
                            
                            if buttonStateCheck {
                                if checkAnswer == answerArray[questionCount] {
                                    print("Correct")
                                    finalAnswer = checkAnswer
                                    score += 1
                                    //ViewThreeFlag = true
                                } else {
                                    print("wrong")
                                    wrongAnswerView = true
                                }
                                textFieldDisabled = true
                            } else {
                                finalAnswer = ""
                                checkAnswer = ""
                                wrongAnswerView = false
                                textFieldDisabled = false
                                questionCount += 1
                                if questionCount + 1 > questionArray.count {
                                    gameEndAlert = true
                                    return
                                }
                               
                            }
                            buttonStateCheck.toggle()
                        }
                        .customButtonStyle()
                    }
                  
                    
                    
                   
                VStack(spacing:10) {
                    HStack(spacing: 20) {
                        Text("Score : \(score)")
                            .font(.title2.weight(.bold))
                        .foregroundStyle(LinearGradient(colors: [.cyan,.red], startPoint: .leading, endPoint: .trailing))
                        
                        Text("Total : \(questionCount) / \(questionArray.count)")
                            .font(.title2.weight(.bold))
                        .foregroundStyle(LinearGradient(colors: [.pink,.indigo], startPoint: .leading, endPoint: .trailing))
                    }
                    
                    Button("Restart") {
                        restart()
                    }
                    .customButton2Style()
                }
               
               Spacer()
                   
                }
            }
            .alert("Well Played", isPresented: $gameEndAlert) {
                Button("OK", action: restart)
            } message: {
                Text("Let's restart the game")
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        dismissKeyboard = false
                    }
                }
            }
            
        }
        
    }
    
  
    
    func tableSelection(_ number: Int) {
        print("table - \(number)")
        tableSelected = number
        withAnimation(.easeOut) {
            ViewOneFlag = false
            ViewTwoFlag = true
            ViewThreeFlag = false
        }
    }
    
    func changeTable() {
        withAnimation(.easeIn) {
            ViewOneFlag = true
            ViewTwoFlag = false
            ViewThreeFlag = false
        }
        
    }
    
    func play() {
        print("1 ---- ",questionSelected)
        print("2 ---- ",difficultySelected)
        
        if questionSelectionFlag && difficultySelectionFlag {
            generateQuestions(table: tableSelected, question: questionSelected, difficulty: difficultySelected)
            moveToMainScreen()
        } else {
            showingAlert = true
        }
    }
    
    func moveToMainScreen() {
        withAnimation(.easeOut) {
            ViewOneFlag = false
            ViewTwoFlag = false
            ViewThreeFlag = true
        }
    }
    


    func generateQuestions(table number: Int,question total: Int,difficulty level: Int) {
        if total == 5 {
            calculate(table: number, total: total, level: level)
        } else if total == 10 {
            calculate(table: number, total: total, level: level)
        } else if total == 15 {
            calculate(table: number, total: total, level: level)
        } else {
            calculate(table: number, total: total, level: level)
        }
        
        print("array Q ",questionArray)
        print("array A ",answerArray)
        questionCount = 0
        //questionCount = questionArray.count
        //print("Count A ",questionCount)
    }
    
    func calculate(table: Int,total: Int,level: Int) {
        questionArray.removeAll()
        answerArray.removeAll()
        for _ in 1...total {
            if level == 0 {
                let easy = Int.random(in: 2...15)
                let ques = "\(table) * \(easy)"
                let ans = table * easy
                print(" level 0  ----- \(ques) ==  \(ans)")
                questionArray.append(ques)
                answerArray.append(String(ans))
            } else if level == 1 {
                let med = Int.random(in: 15...30)
                let ques = "\(table) * \(med)"
                let ans = table * med
                print(" level 1 ----- \(ques) ==  \(ans)")
                questionArray.append(ques)
                answerArray.append(String(ans))
            } else {
                let hard = Int.random(in: 30...45)
                let ques = "\(table) * \(hard)"
                let ans = table * hard
                print(" level 2 ----- \(ques) ==  \(ans)")
                questionArray.append(ques)
                answerArray.append(String(ans))
            }
        }
    }
    
    func restart() {
        questionArray.removeAll()
        answerArray.removeAll()
        questionCount = 0
        score = 0
        checkAnswer = ""
        ViewOneFlag = true
        ViewTwoFlag = false
        ViewThreeFlag = false
        
        questionSelected = 0
        questionSelectionFlag = false
        difficultySelected = 0
        difficultySelectionFlag = false
        
        
        textFieldDisabled = false
        wrongAnswerView = false
        buttonStateCheck = true
        finalAnswer = ""
        checkAnswer = ""
        
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
