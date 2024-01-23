//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ramanan on 13/10/22.
//

import SwiftUI

//challenge P3
struct FlagImage: View {
    var imageName: String
    var accessibilityLabel: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .accessibilityLabel(accessibilityLabel)
    }
}

//challenge P3
struct CustomTitleFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle.bold())
    }
}

extension View {
    func customTitleFontStyle() -> some View {
        modifier(CustomTitleFont())
    }
}


struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0 //challenge
    @State private var gameCount = 0 //challenge
    @State private var gameEndAlert = false //challenge
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    //P15 : Accessibility
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var colorArray = [Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray] //try
    //challenge P6
    @State private var animationAmount = 0.0
    @State private var userTapped = -1
    @State private var dullOpacity = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .customTitleFontStyle() //challenge P3
                    //.font(.largeTitle.bold())
                    //.foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            userTapped = number //challenge P6
                            animationAmount += 360
                            flagTapped(id: number, country: countries[number])
                        } label: {
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                            FlagImage(imageName: countries[number], accessibilityLabel: labels[countries[number]] ?? "Unknown Flag") //challenge P3 & P15 Accessibility
                                
                        }
                        .opacity(userTapped == number ? 1.0 : dullOpacity) //challenge P6
                        .rotation3DEffect(.degrees(animationAmount), axis: (userTapped == number) ? (x: 0 , y: 1, z: 0) : (x: 1 , y: 0, z: 0) ) //challenge P6
                        .animation(.default, value: animationAmount) //challenge P6
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                //try
                HStack {
                    ForEach(0..<8) { item in
                        HStack {
                            colorArray[item]
                        }
                        .clipShape(Circle())
                        .shadow(radius: 2)
                    }
                }
                .frame(maxWidth: .infinity,  maxHeight: 16)
                .padding(10)
                
                Text("Score: \(score)")
                    .customTitleFontStyle()
                    //.foregroundColor(.white)
                    //.font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Well Played!", isPresented: $gameEndAlert) {
            Button("OK", action: restart)
        } message: {
            Text("Final score is \(score). Let's restart the game")
        }//challenge
    }
    
    func flagTapped(id number: Int, country name: String) {
        dullOpacity = 0.75 //challenge P6
        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
            colorArray[gameCount] = Color.green
        } else {
            scoreTitle = "Wrong! That’s the flag of \(name)" //challenge
            //score -= 1
            colorArray[gameCount] = Color.orange
        }
        //showingScore = true
        
        gameCount += 1 //challenge
        if gameCount == 8 {
            gameEndAlert = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        resetAnimationValues() //challenge P6
    }
    
    //challenge
    func restart() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        gameCount = 0
        score = 0
        colorArray.removeAll()
        for _ in 0...7 {
            colorArray.append(Color.gray)
        }
        resetAnimationValues() //challenge P6
    }
    
    //challenge P6
    func resetAnimationValues() {
        userTapped = -1 
        dullOpacity = 1.0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
