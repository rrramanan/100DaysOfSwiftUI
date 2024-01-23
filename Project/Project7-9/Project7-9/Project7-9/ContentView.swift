//
//  ContentView.swift
//  Project7-9
//
//  Created by Ramanan on 29/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @StateObject var getData = AddData()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(getData.items) { info in
                        NavigationLink {
                            //DetailView(uuid: info.id, title: info.Title, details: info.Details, count: info.Count, dataCopy: getData)
                            
                            //DetailView(userActivity: info, dataCopy: getData)
                            DetailView(dataCopy: getData, userActivity: info)
                        } label: {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(info.Title)
                                        .font(.title3.bold())
                                    Text(info.Details)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text("Streak: \(info.Count) \(info.Count <= 1 ? "day" : "days")")
                                    .font(.footnote.bold())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showSheet) {
                AddView(addData: getData)
            }
        }//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
