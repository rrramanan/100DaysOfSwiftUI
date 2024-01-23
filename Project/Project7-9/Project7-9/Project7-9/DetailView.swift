//
//  DetailView.swift
//  Project7-9
//
//  Created by Ramanan on 29/11/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var dataCopy: AddData
   //@State private var modifiedCount = 0
    
    var userActivity: UserData
    //var dataCopy: AddData
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(userActivity.Title)
                .font(.largeTitle.weight(.heavy))
            
            Text(userActivity.Details)
                .font(.title3.weight(.medium))
            
            Text("Count: \(userActivity.Count) ")
                .font(.title3.weight(.medium))
            
            Spacer()
            
            Button("Add Count") {
               /*
                if let i = dataCopy.items.firstIndex(of: UserData(id: userActivity.id, Title: userActivity.Title, Details: userActivity.Details, Count: userActivity.Count)) {
                    //count += 1
                    //modifiedCount = count
                    //modifiedCount += 1
                    dataCopy.items[i] = UserData(Title: userActivity.Title, Details: userActivity.Details, Count: userActivity.Count + 1)
                }
                */
                
                if let i = dataCopy.items.firstIndex(of: UserData(id: userActivity.id, Title: userActivity.Title, Details: userActivity.Details, Count: userActivity.Count)) {
                    //count += 1
                    //modifiedCount = count
                    //modifiedCount += 1
                    
                    //dataCopy.items.remove(at: i)
                    var temp = userActivity
                    temp.Count = temp.Count + 1
                    //dataCopy.items.insert(temp, at: i)
                    dataCopy.items[i] = temp
                    //dataCopy.items[i] = UserData(Title: userActivity.Title, Details: userActivity.Details, Count: userActivity.Count + 1)
                }
                
                /*
                if let index = self.dataCopy.items.firstIndex(where: { $0 == self.userActivity }) {
                    self.dataCopy.items.remove(at: index)
                    var tempActivity = self.userActivity
                    tempActivity.Count = userActivity.Count + 1//self.completed
                    self.dataCopy.items.insert(tempActivity, at: index)
                }
                */
                
            }
            .frame(width: 200, height: 50)
            .background(.cyan.opacity(0.5))
            .foregroundColor(.white)
            .font(.title2.monospaced())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
        }
        .frame( maxWidth: .infinity)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        //DetailView(userActivity: UserData(Title: "Walking", Details: "10000 Steps", Count: 0), dataCopy: AddData())
        DetailView(dataCopy: AddData(), userActivity: UserData(Title: "", Details: "", Count: 0))
            .preferredColorScheme(.dark)
    }
}
