//
//  TagView.swift
//  Project10-12
//
//  Created by Ramanan on 21/12/22.
//

import SwiftUI

struct TagView: View {
    let userTags: [String]
    
    var body: some View {
        VStack {
            Group {
                Text("Tags (\(userTags.count))")
                    .foregroundColor(.brown)
                .font(.headline.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(userTags, id: \.self) { tag in
                            Text(tag)
                                .padding(7)
                                .foregroundColor(.white)
                                .background(LinearGradient(colors: [.gray,.indigo.opacity(0.6)], startPoint: .leading, endPoint: .trailing))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
            }//
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(userTags: [String]())
            .preferredColorScheme(.dark)
    }
}
