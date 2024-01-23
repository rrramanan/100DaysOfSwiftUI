//
//  TagView.swift
//  Project10-12
//
//  Created by Ramanan on 21/12/22.
//

import SwiftUI

struct TagView: View {
    let userTag: [String]
    
    var body: some View {
        VStack {
            Group {
                Text("Tags (\(userTag.count))")
                    .foregroundColor(.purple)
                .font(.headline.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(userTag, id: \.self) { tag in
                            Text(tag)
                                .padding(7)
                                .foregroundColor(.white)
                                .background(.orange.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
            }
        }//
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(userTag: [String]())
            .preferredColorScheme(.dark)
    }
}
