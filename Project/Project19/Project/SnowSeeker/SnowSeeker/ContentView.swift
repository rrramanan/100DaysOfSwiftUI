//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ramanan on 23/02/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    //challenge
    enum FilterType {
        case none,alphabetical,country
    }
    @State var filterSelected: FilterType
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            //challenge //:filteredResorts
            List(filteredList()) { resort in
                NavigationLink {
                   ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.primary, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showActionSheet = true
                    } label: {
                        Image(systemName: "sparkles")
                    }
                }
            }
            .confirmationDialog("Filter",isPresented: $showActionSheet) {
                Button("Default") { filterSelected = .none }
                Button("Name") { filterSelected = .alphabetical }
                Button("Country") { filterSelected = .country }
            } message: {
                Text("Filter")
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyNavigationView()
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
     //challenge
    func filteredList() -> [Resort] {
        switch filterSelected {
        case .none:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted()
        case .country:
            return filteredResorts.sorted(by: Resort.countrySort)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filterSelected: .none)
            .preferredColorScheme(.dark)
    }
}
