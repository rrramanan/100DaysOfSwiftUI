//
//  ContentView.swift
//  Project1-3
//
//  Created by Ramanan on 17/10/22.
//

import SwiftUI


struct ContentView: View {
    @State private var appScore = 0
    @State private var playerScore = 0
    @State private var gameCount = 0
    @State private var showAlert = false
    @State private var appData = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var switchGameState = Bool.random()
    @State private var emojiHappy = ["😍","👻","💃"]
    @State private var emojiSad = ["🤯","😢","💆‍♀️"]
    @State private var randomInt = Int.random(in: 0...2)
    @State private var pickEmoji = "👏"
    
    var body: some View {
        
            ZStack {
                //[.indigo,.gray,.black,.indigo]
                //[.indigo,.gray,.blue,.gray,.gray,.brown]
                //[.indigo,.black,.black,.blue]
                LinearGradient(colors: [.indigo,.black,.black,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        Text("ROCK   PAPER\n  SCISSORS")
                            .frame(maxWidth:.infinity,alignment: .center)
                            .padding(9)
                            .font(.largeTitle.weight(.heavy).monospaced().uppercaseSmallCaps())
                            .minimumScaleFactor(0.9)
                            .foregroundStyle(LinearGradient(colors: [.black,.gray,.white,.black,.gray],startPoint: .leading,endPoint: .trailing))
                            .background(LinearGradient(colors: [.gray,.gray,.white,.gray,.white,.gray,.gray],startPoint: .leading,endPoint: .trailing))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        VStack(spacing:20) {
                            
                            VStack(spacing: 20) {
                                VStack {
                                    Text("App selected: \(appData[0])")
                                        .padding(5)
                                        .font(.title3.weight(.bold).monospaced())
                                        .foregroundColor(.white)
                                        
                                }
                                .background(LinearGradient(colors: [.black,.blue,.gray], startPoint: .leading, endPoint: .trailing))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                               
                                VStack {
                                 switch appData[0]{
                                    case "Rock":
                                        Button("🪨") {}
                                         .background(.purple)
                                         .clipShape(Circle())
                                         .padding(5)
                                         .background(.gray)
                                         .clipShape(Circle())
                                     
                                    case "Paper":
                                        Button("📰") {}
                                        .background(.teal)
                                        .clipShape(Circle())
                                        .padding(5)
                                        .background(.white)
                                        .clipShape(Circle())
                                        
                                    case "Scissors":
                                        Button("✂️") {}
                                        .background(.black)
                                        .clipShape(Circle())
                                        .padding(5)
                                        .background(.pink)
                                        .clipShape(Circle())
                                    default:
                                        Button("RPS") {}
                                    }
                                }
                                .font(.system(size: 100))
                               
                            }

                            HStack {
                                Text("💬:\(pickEmoji)")
                                    .font(.title2.weight(.semibold).monospaced())
                                    .foregroundColor(.white)
                                
                                Spacer()
                                Text("Score: \(appScore)")
                                    .font(.title2.weight(.heavy).monospaced())
                                    .foregroundColor(.white)
                            }
                            
                        }//
                        
                    }//
                    .frame(maxWidth:.infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                   
                    Spacer()
                    Spacer()
                    
                    VStack(spacing:20) {
                        
                        HStack {
                            Text("Score: \(playerScore)")
                                .font(.title2.weight(.heavy).monospaced())
                                .foregroundColor(.white)
                            Spacer()
                            Text("Round: \(gameCount)/10")
                                .font(.title2.weight(.semibold).monospaced())
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing:20) {
                            
                            VStack {
                                Text("Play the \(switchGameState == true ? "right" : "wrong") move to win")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.9)
                                    .font(.title3.weight(.bold).monospaced())
                                    .padding(5)
                                    .foregroundColor(.white)
                                   
                            }
                            .background(LinearGradient(colors: [.purple,.gray,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            /*
                            ForEach(0..<3) { index in
                                Button(appData[index]) {
                                    result(userSelection:appData[index])
                                }
                            }
                            */
                            
                            HStack(spacing:20) {
                                Button("🪨") {
                                    result(userSelection: "Rock")
                                }
                                .clipShape(Circle())
                                .padding(4)
                                .background(LinearGradient(colors: [.black,.gray,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Circle())
                              
                                Button("📃") {
                                    result(userSelection: "Paper")
                                }
                                .clipShape(Circle())
                                .padding(4)
                                .background(LinearGradient(colors: [.indigo,.cyan,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Circle())

                                Button("✂️") {
                                    result(userSelection: "Scissors")
                                }
                                .clipShape(Circle())
                                .padding(4)
                                .background(LinearGradient(colors: [.red,.gray,.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Circle())
                            }
                            .font(.system(size: 80))
                        }
                    }//
                    .frame(maxWidth:.infinity)
                    .padding()
                    
                    Spacer()
                    Spacer()
                }
                
            }
            .alert("Well Played!👍", isPresented: $showAlert) {
                Button("OK", action: restart)
            } message: {
                Text("Your score: \(playerScore). Let's restart the game.")
            }
    }
    
    func result(userSelection: String) {
        let appSelection = appData[0]
        
        randomInt = Int.random(in: 0...2)
        print("random INt -= ",randomInt)
        
        if (appSelection == "Rock") && (userSelection == "Paper") {
            switchGameState == true ? (playerScore += 1) : (appScore += 1)
            switchGameState == true ? (pickEmoji = emojiSad[randomInt]) : (pickEmoji = emojiHappy[randomInt])
        } else if (appSelection == "Rock") && (userSelection == "Scissors") {
            switchGameState == true ? (appScore += 1) : (playerScore += 1)
            switchGameState == true ? (pickEmoji = emojiHappy[randomInt]) : (pickEmoji = emojiSad[randomInt])
        } else if (appSelection == "Paper") && (userSelection == "Rock") {
            switchGameState == true ? (appScore += 1) : (playerScore += 1)
            switchGameState == true ? (pickEmoji = emojiHappy[randomInt]) : (pickEmoji = emojiSad[randomInt])
        } else if (appSelection == "Paper") && (userSelection == "Scissors") {
            switchGameState == true ? (playerScore += 1) : (appScore += 1)
            switchGameState == true ? (pickEmoji = emojiSad[randomInt]) : (pickEmoji = emojiHappy[randomInt])
        } else if (appSelection == "Scissors") && (userSelection == "Rock") {
            switchGameState == true ? (playerScore += 1) : (appScore += 1)
            switchGameState == true ? (pickEmoji = emojiSad[randomInt]) : (pickEmoji = emojiHappy[randomInt])
        } else if (appSelection == "Scissors") && (userSelection == "Paper") {
            switchGameState == true ? (appScore += 1) : (playerScore += 1)
            switchGameState == true ? (pickEmoji = emojiHappy[randomInt]) : (pickEmoji = emojiSad[randomInt])
        }
        
        gameCount += 1
        if gameCount == 10 {
            showAlert = true
        } else {
            reloadAppData()
            toggleState()
        }
    }
    
    func restart() {
        appScore = 0
        playerScore = 0
        gameCount = 0
        pickEmoji = "👏"
        reloadAppData()
        toggleState()
    }
    
    func reloadAppData() {
        appData.shuffle()
        print("appSelection = " ,appData[0])
    }
    
    func toggleState() {
        switchGameState.toggle()
        print("switchGameState = ",switchGameState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
