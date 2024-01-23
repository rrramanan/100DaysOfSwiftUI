//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ramanan on 18/11/22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            .accessibilityElement() //Challenge P15
            .accessibilityLabel("Astronaut Details")
            .accessibilityValue("Image of \(astronaut.name) with description followed\(astronaut.description)")
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .accessibilityLabel(astronaut.name) //Challenge P15
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityLabel("Astronaut Detail View")
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
