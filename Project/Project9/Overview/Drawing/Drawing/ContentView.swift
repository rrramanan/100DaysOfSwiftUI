//
//  ContentView.swift
//  Drawing
//
//  Created by Ramanan on 23/11/22.
//

import SwiftUI

//challenge
struct ColorCylingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    //.strokeBorder()
                    //.strokeBorder(color(for: value, brightess: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightess: 1),
                                color(for: value, brightess: 0.5),
                            ]),
                            startPoint: UnitPoint(x: 0.5, y: 1),
                            endPoint: UnitPoint(x: 0, y: 0.5)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightess: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightess)
    }
    
}

//challenge
struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxY, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midY, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minY, y: rect.midX))
        path.move(to: CGPoint(x: rect.midY, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midY, y: rect.minY))
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

/*
struct Arc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockWise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockWise)
        
        return path
    }
}
*/

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockWise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockWise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
}


struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
    
}


struct ColorCylingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    //.strokeBorder()
                    //.strokeBorder(color(for: value, brightess: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightess: 1),
                                color(for: value, brightess: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightess: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightess)
    }
    
}

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}


struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    @State private var amount = 0.0
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var arrowWidth = 10.0 //challenge
    
    var body: some View {
        
        /*
        // #1 --- Creating custom paths with SwiftUI
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            //path.closeSubpath()
        }
        //.fill(.blue)
        //.stroke(.blue, lineWidth: 10)
        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        */
        
        
        
        // #2 --- Paths vs shapes in SwiftUI
        /*
        Triangle()
            //.fill(.red)
            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 350, height: 300)
        */
        /*
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockWise: true)
            .stroke(.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
        
        */
        
        
        // #3 --- Adding strokeBorder() support with InsettableShape
        //Circle()
            //.strokeBorder(.blue, lineWidth: 40) //shape and insettable protocol - circle
        
       // Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockWise: true)
            //.strokeBorder(.blue, lineWidth: 40)
        
        
        
        // #4 --- Transforming shapes using CGAffineTransform and even-odd fills
        /*
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(.red, lineWidth: 1)
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal,.bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
        */
       
        // #5 --- Creative borders and fills using ImagePaint
        
        //Text("Hello World")
            //.frame(width: 300, height: 300)
            //.border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.4, width: 1, height: 0.2) ,scale: 0.1), width: 30)
        
       //Capsule()
            //.strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5) ,scale: 0.3), lineWidth: 20)
            //.frame(width: 300, height: 200)
        
        
        // #6 --- Enabling high-performance Metal rendering with drawingGroup()
        /*
        VStack {
            ColorCylingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
        */
        
        // #7 --- Special effects in SwiftUI: blurs, blending, and more
        
        
        ZStack {
            Image("Example")
            Rectangle()
                .fill(.red)
                .blendMode(.multiply)
        }
        
        
        
        Image("Example")
            .colorMultiply(.red)
        
        
        /*
         //
        VStack {
            
            ZStack {
                Circle()
                    //.fill(.red)
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    //.fill(.green)
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    //.fill(.blue)
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
                
            }
            .frame(width: 300, height: 300)
            
            
    
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        
         //
        
        */
        
        // #8 ---   Animating simple shapes with animatableData
        /*
       Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
         */
        
        
        // #9 ---  Animating complex shapes with AnimatablePair
        /*
        CheckerBoard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
        */
        
        /*
        // Challenge --->
        VStack {
            Spacer()
            Arrow()
                .stroke(.red, style: StrokeStyle(lineWidth: arrowWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation(.default.delay(0.10)) {
                        if arrowWidth == 70 {
                            return
                        } else {
                            arrowWidth += 10
                        }
                    }
                    
                }
            Spacer()
            Stepper("Width", value: $arrowWidth.animation(.default.delay(0.10)), in: 10...70, step: 5)
                .padding()
            Spacer()
            
            ColorCylingRectangle(amount: colorCycle)
                .frame(width: 240, height: 200)
            Slider(value: $colorCycle)
            Spacer()
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
