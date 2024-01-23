//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Ramanan on 15/02/23.
//

import SwiftUI

// #5 -- Understanding frames and coordinates inside GeometryReader

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            
            Text("Right")
        }
    }
}

// #3 -- Create Custom Alignment guides

extension VerticalAlignment {
    //struct
     enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}


struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
       
        /*
        // #2 -- frame alignment
        Text("Live long and prosper!")
            .frame(width: 300, height: 300, alignment: .topLeading)
            .offset(x: 30, y: 40)
        */
        
        /*
        //.bottom //#2 -- stack alignment
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        */
        
        /*
        // #2 -- customize alignment for each view
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
            
            /*
            Text("Hello, world!")
                .alignmentGuide(.leading) { d in
                    //d[.leading]
                    d[.trailing]
                }
            Text("This is a longer line of text")
            */
        }
        .background(.red)
        .frame(width: 400, height: 400)
        
        */
        
        
        /*
        // #3 -- Create Custom Alignment guides
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostarws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("twitter")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
        
        */
        
        /*
        // #4 -- Absolute positioning for SwiftUI views
        
        Text("Hello, world!")
            //.position(x: 100, y: 100)
            .offset(x: 100, y: 100)
            .background(.red)
            //.offset(x: 100, y: 100)
        */
        
        
        /*
        // #5 -- Understanding frames and coordinates inside GeometryReader
        
        /*
        VStack {
            GeometryReader { geo in
                Text("Hello, world!")
                    .frame(width: geo.size.width * 0.9)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
                .background(.blue)
        }
        */
        
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
        */
        
        
       // #6 -- ScrollView effects using GeometryReader
        //\(geo.frame(in: .global).minY)
        
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index) ")
                            .font(.title)
                            .frame(maxWidth:.infinity)
                            //.background(colors[index % 7]) //replaced
                            .background(Color(hue: min(1.0, geo.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            //.opacity(geo.frame(in: .global).minY < 200 ? 0.2 : 1) // challenge
                            //.opacity(geo.frame(in: .global).minY <= 200 ? (Double(geo.frame(in: .global).minY / 2) / 100) : 1) // challenge
                            .opacity(geo.frame(in: .global).minY / 200)
                            //.scaleEffect(geo.frame(in: .global).minY <= 300 ? 0.7 : geo.frame(in: .global).minY <= fullView.size.height - 100 ? 1 : 1.5) //challenge
                            .scaleEffect(max(0.7, geo.frame(in: .global).minY / 400 ))
                    }
                    .frame(height: 40)
                }
            }
        }
        
        
        /*
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<20) { num in
                    GeometryReader { geo in
                        Text("Numebr \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
        */
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


// //.opacity(geo.frame(in: .global).minY / fullView.size.height)
