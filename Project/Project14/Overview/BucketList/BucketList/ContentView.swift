//
//  ContentView.swift
//  BucketList
//
//  Created by Ramanan on 04/01/23.
//

import MapKit
import LocalAuthentication
import SwiftUI

// #1 -- Adding conformance to Comparable for custom types
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}


// #3 -- Switching view states with enums

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

//4 -- Integrating MapKit with SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


// MARK: View -----------------------

struct ContentView: View {
   // let values = [1, 5, 3, 6, 2, 9].sorted()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
//    .sorted {
//        $0.lastName < $1.lastName
//    }
    
    var loadingState = LoadingState.loading
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of london", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    @State private var isUnlocked = false
    
    var body: some View {
//        List(users) { user in
//            Text("\(user.firstName) \(user.lastName)")
//        }
        
        
        /*
        // #2 -- Writing data to the documents directory
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        */
        
        // #3 -- Switching view states with enums
        
//        if Bool.random() {
//            Rectangle()
//        } else {
//            Circle()
//        }
        
      
//        if loadingState == .loading {
//            LoadingView()
//        } else if loadingState == .success {
//            SuccessView()
//        } else if loadingState == .failed {
//            FailedView()
//        }
        
//        switch loadingState {
//        case .loading:
//            LoadingView()
//        case .success:
//            SuccessView()
//        case .failed:
//            FailedView()
//        }
        
        
        
        //4 -- Integrating MapKit with SwiftUI
        
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                //MapMarker(coordinate: location.coordinate)
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        //VStack {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
//                            .onTapGesture {
//                                print("Tapped on \(location.name)")
//                            }
                        //Text(location.name)
                        //}
                    }
                }
            }
            .navigationTitle("London Explorer")
        }
        
        
        /*
        // 5 -- Using Touch ID and Face ID with SwiftUI
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
        */
        
    }
    
    
    
    
     // MARK: Functions ----------------
    
    
    // #2 -- Writing data to the documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // 5 -- Using Touch ID and Face ID with SwiftUI
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                  // authenticated successfully
                    isUnlocked = true
                } else {
                  // there was a problem
                }
            }
        } else {
            // no biometrics
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
