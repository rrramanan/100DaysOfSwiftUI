//
//  ContentView.swift
//  HotProspects
//
//  Created by Ramanan on 27/01/23.
//

import SwiftUI
import UserNotifications
import SamplePackage


// #1 Reading custom values from the environment with @EnvironmentObject

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}


//#3 -- Manually publishing ObservableObject changes

@MainActor class DelayedUpdater: ObservableObject {
    //@Published
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject  var user = User() //private
    @State private var selectedTab = "One"
    
    @StateObject private var updater = DelayedUpdater()
    
    @State private var output = ""
    
    @State private var backgroundColor = Color.red
    
    
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        /*
        VStack {
            EditView() //.environmentObject(user)
            DisplayView() //.environmentObject(user)
        }
        .environmentObject(user)
        */
        
        /*
        //#2 --- Creating tabs with TabView and tabItem()
        
        TabView(selection: $selectedTab) {
            Text("Tab1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
            Text("Tab2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
        */
        
        // #3 -- Manually publishing ObservableObject changes
        
        Text("Value is \(updater.value)")
        
        // #4 -- Understanding Swift’s Result type
        /*
        Text(output)
            .task {
                await fetchReadings()
            }
        */
        
        
        /*
        // #5 -- Controlling image interpolation in SwiftUI
        
        Image("example")
            //.interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
        */
        
        /*
        // #6 -- Creating context menus
        
        VStack {
            Text("Hello, world!")
                .padding()
                .background(backgroundColor)
            
            Text("CHange Color")
                .padding()
                .contextMenu {
                    /*
                    Button("Red") {
                        backgroundColor = .red
                    }
                    */
                    
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
        */
        
        /*
        // #7 -- Adding custom row swipe actions to a List
        
        List {
            Text("Taylor Swift")
                /*
                .swipeActions {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Send message", systemImage: "message")
                    }
                }
                */
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
        */
        
        /*
        // #8 -- Scheduling local notifications
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dogs"
                content.subtitle = "They look hungry" 
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
        */
        
        // #9 -- Adding Swift package dependencies in Xcode
        //Text(results)
        
    }
    
    // #4 -- Understanding Swift’s Result type
    
    func fetchReadings() async {
        /*
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        }
        catch {
            print("Download error")
        }
        */
        
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        /*
        do {
            output = try result.get()
        } catch {
            print("Downoad error")
        }
        */
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Download error: \(error.localizedDescription)"
        }
    }
    
    
    // #9 -- Adding Swift package dependencies in Xcode
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
