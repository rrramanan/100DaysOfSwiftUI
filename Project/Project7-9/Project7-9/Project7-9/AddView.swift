//
//  AddView.swift
//  Project7-9
//
//  Created by Ramanan on 29/11/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var addData: AddData
    @Environment(\.dismiss) var dismiss
    @State private var titleText = ""
    @State private var detailText = ""
    
    var body: some View {
        NavigationView {
            Form {
             TextField("Title", text: $titleText)
             TextField("Detail", text: $detailText)
            }
            .navigationTitle("Add New Habit")
            .navigationBarItems(leading:
                Button("Cancel", action: {
                dismiss()
            }), trailing:
                Button("Save", action: {
                let item = UserData(Title: titleText, Details: detailText, Count: 0)
                addData.items.append(item)
                dismiss()
            })
            .disabled((titleText.count > 0) && (detailText.count > 0) ? false : true)
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(addData: AddData())
            .preferredColorScheme(.dark)
    }
}
