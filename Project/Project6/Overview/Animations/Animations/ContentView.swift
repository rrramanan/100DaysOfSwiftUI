//
//  ContentView.swift
//  Animations
//
//  Created by Ramanan on 31/10/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}


extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}


struct ContentView: View {
    @State private var animationAmount = 1.0 //0.0 //1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello, SwiftUI")
    @State private var isShowingRed = false
    
    var body: some View {
        
        //#1 Creating implicit animations
        /*
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
    */
          
        
        
        // #2 Customizing animations in SwiftUI
        
        /*
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    //.delay(1)
                    //.repeatCount(2, autoreverses: true) //3
                        .repeatForever(autoreverses: false)
                    ,
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
        //.scaleEffect(animationAmount)
        //.blur(radius: (animationAmount - 1) * 3)
        //.animation(.default, value: animationAmount)
        //.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
    
        */
    
    
        //#3 - animation binding
      
        print(animationAmount)
        
       return VStack {
            Stepper("Scale Amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    
        
        //#4 - Creating explicit animations
        /*
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        */
        
        //#5 - Controlling the animation stack
        
        /*
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
       //.background(enabled ? .blue : .red)
        .animation(nil, value: enabled) //can be nill
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        .background(enabled ? .blue : .red) // clipshape disabled
        */
        
        
        //#6 -  Animating gestures
        
        //6.1
        /*
        LinearGradient(gradient: Gradient(colors: [.yellow,.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ dragAmount = $0.translation })
                    .onEnded({ _ in
                        withAnimation {
                            dragAmount = .zero
                        }
                    })
            )
            //.animation(.spring(), value: dragAmount)
        */
        
        //6.2
        
        /*
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(
                        .default.delay(Double(num) / 20),
                        value: dragAmount
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragAmount = $0.translation })
                .onEnded({ _ in
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
        
        */
        
        //#7 -  Showing and hiding views with transitions
 /*
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                    
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
*/
        
        //#8 -  Building custom transitions using ViewModifier
        
        
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 200, height: 200)
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.pivot)
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                isShowingRed.toggle()
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
