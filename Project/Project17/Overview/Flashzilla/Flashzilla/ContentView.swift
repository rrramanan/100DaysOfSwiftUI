//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ramanan on 06/02/23.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    //@State private var currentAmount = 0.0
    //@State private var finalAmount = 1.0
    
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var engine: CHHapticEngine?
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
            
        // #1 -- How to use gestures in SwiftUI
        
        /*
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
         
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
        */
        
        
        
        /*
        Text("Hello, world!")
            .padding()
         */
         /*
            .onTapGesture(count: 2) {
                print("Double tapped!")
            }
         */
        
        /*
            .onLongPressGesture {
              print("Long pressed!")
            }
         */
       
        /*
                                                //2
            .onLongPressGesture(minimumDuration: 1) {
                print("Long pressed!")
            } onPressingChanged: { inProgess in
                print("In progess \(inProgess)")
            }
          */
           
           /*
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged({ amount in
                        currentAmount = amount - 1
                    })
                    .onEnded({ amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    })
            )
            */
    
         /*
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged({ amount in
                        currentAmount = amount
                    })
                    .onEnded({ amount in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    })
            )
        */
    
        
        
        
        /*
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    print("Text tapped!") //child as priority
                }
        }
         */
        /*
        .onTapGesture {
            print("VStack tapped")
        }
        */
        /*
        .highPriorityGesture(
            TapGesture()
                .onEnded({ _ in
                     print("VStack tapped")
                })
        )
        */
        /*
        .simultaneousGesture(
            TapGesture()
                .onEnded({ _ in
                     print("VStack tapped")
                })
        )
        */

        
        
        
        
        // #2 -- Making vibrations with UINotificationFeedbackGenerator and Core Haptics
        /*
        Text("Hello, world!")
            .padding()
           //.onTapGesture(perform: simpleSuccess)
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
        */
        
        
        
        
        
        // #3 -- Disabling user interactivity with allowsHitTesting()
    
        
        ZStack {
          Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
                .allowsHitTesting(false)
        }
        
        
        /*
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
        */
        
        
        // #4 -- Triggering events repeatedly using a timer
        /*
        Text("Hello, world!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
        */
        
        // #5 -- How to be notified when your SwiftUI app moves to the background
        /*
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                  print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
        */
        
        // #6 -- Supporting specific accessibility needs with SwiftUI
         /*
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
        */
        
        /*
        Text("Hello, world!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation { 
                    scale *= 1.5
                }
                /*
                if reduceMotion {
                    scale *= 1.5
                } else {
                    withAnimation {
                        scale *= 1.5
                    }
                }
                */
            }
        */
        
        /*
        Text("Hello, world!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
        */
        
    }//
    
    // #6 -- Supporting specific accessibility needs with SwiftUI
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    
    
    // #2 -- Making vibrations with UINotificationFeedbackGenerator and Core Haptics
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        /*
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 0)
        events.append(event)
        */
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
