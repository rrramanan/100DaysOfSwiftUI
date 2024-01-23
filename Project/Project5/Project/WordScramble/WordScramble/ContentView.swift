//
//  ContentView.swift
//  WordScramble
//
//  Created by Ramanan on 27/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0 //challenge
    @State private var wordCount = 0 //challenge
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    HStack {
                        HStack {
                            Text("Score")
                                .font(.headline.weight(.semibold).monospaced())
                            Text("\(score)")
                                .font(.title2.weight(.regular).monospacedDigit())
                                .foregroundColor(.orange)
                        }
                        .frame(maxWidth: .infinity)
                        .background(.thickMaterial)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        HStack {
                            Text("Count")
                                .font(.headline.weight(.semibold).monospaced())
                            Text("\(usedWords.count)")
                                .font(.title2.weight(.regular).monospacedDigit())
                                .foregroundColor(.orange)
                        }
                        .frame(maxWidth:.infinity)
                        .background(.thickMaterial)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }//challenge
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement() //P15 accessibility
                        .accessibilityLabel(word) // ("\(word) \(word.count) letters")
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button {
                    startGame()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: "sparkles")
                            .foregroundColor(.orange)
                        Text("Restart")
                            .foregroundColor(.brown)
                            .font(.subheadline.weight(.medium).monospaced())
                            .padding(4)
                    }
                }
                .background(.thickMaterial)
                .background(.primary)
                .clipShape(Capsule())
            }//challenge
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2, answer != rootWord  else {
            if answer == rootWord {
                wordError(title: "Word not allowed", message: "You can't repeat the root word")
            } else {
                wordError(title: "Word not allowed", message: "Too short! Try adding more characters.")
            }
            return
        }//challenge
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            wordCount = answer.count
            //print("wordCount ",wordCount)
            usedWords.insert(answer, at: 0)
            scoreCalculation()
        }
        newWord = ""
    }
    
    func startGame() {
        newWord = ""
        score = 0
        wordCount = 0
        withAnimation {
            if usedWords.count > 0 { usedWords.removeAll() }
        }//challenge
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
       
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func scoreCalculation() {
        switch wordCount {
        case 3...4:
            score += 2
        case 5:
            score += 3
        case 6...:
            score += 4
        default:
            score += 0
        }
        
        switch usedWords.count {
        case 3...4:
            score += 1
        case 5:
            score += 2
        case 6:
            score += 3
        case 7:
            score += 4
        case 8...15:
            score += 5
        case 16...25:
            score += 6
        case 26...35:
            score += 7
        case 36...45:
            score += 8
        case 46...:
            score += 10
        default:
            score += 0
        }
    }//challenge
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
