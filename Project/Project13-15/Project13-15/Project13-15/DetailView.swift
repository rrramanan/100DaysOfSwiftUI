//
//  DetailView.swift
//  Project13-15
//
//  Created by Ramanan on 24/01/23.
//

import SwiftUI

struct DetailView: View {
    var user: UIImage
    
    var body: some View {
        VStack {
            
            Image(uiImage: user)
                .resizable()
            .scaledToFit()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: UIImage())
            .preferredColorScheme(.dark)
    }
}
