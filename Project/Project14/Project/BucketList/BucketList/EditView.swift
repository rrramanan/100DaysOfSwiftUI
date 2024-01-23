//
//  EditView.swift
//  BucketList
//
//  Created by Ramanan on 06/01/23.
//

import SwiftUI

struct EditView: View {
    
    @StateObject  var editViewModel = EditPageViewModel(name: "", description: "", location: Location.example)
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    let location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("place name", text: $name)//$editViewModel.name
                    TextField("place decription", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        
    
        //editViewModel._name = Published(initialValue: location.name)
        _editViewModel = StateObject(wrappedValue: EditPageViewModel(name: "", description: "", location: Location.example))
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
  
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
        
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in}
            .preferredColorScheme(.dark)
    }
}





/*
 
 enum LoadingState {
     case loading, loaded, failed
 }
 
 @Environment(\.dismiss) var dismiss
 let location: Location
 var onSave: (Location) -> Void
 
 @State private var name: String
 @State private var description: String
 
 @State private var loadingState = LoadingState.loading
 @State private var pages = [Page]()
 
 var body: some View {
     NavigationView {
         Form {
             Section {
                 TextField("place name", text: $name)
                 TextField("place decription", text: $description)
             }
             
             Section("Nearby...") {
                 switch loadingState {
                 case .loading:
                     Text("Loading...")
                 case .loaded:
                     ForEach(pages, id: \.pageid) { page in
                         Text(page.title)
                             .font(.headline)
                         + Text(": ")
                         + Text(page.description)
                             .italic()
                     }
                 case .failed:
                     Text("Please try again later.")
                 }
             }
         }
         .navigationTitle("Place details")
         .toolbar {
             Button("Save") {
                 var newLocation = location
                 newLocation.id = UUID()
                 newLocation.name = name
                 newLocation.description = description
                 
                 onSave(newLocation)
                 dismiss()
             }
         }
         .task {
             await fetchNearbyPlaces()
         }
     }
 }
 
 init(location: Location, onSave: @escaping (Location) -> Void) {
     self.location = location
     self.onSave = onSave
     
     _name = State(initialValue: location.name)
     _description = State(initialValue: location.description)
 }
 
 // #4 -- Downloading data from Wikipedia
 func fetchNearbyPlaces() async {
     let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

     guard let url = URL(string: urlString) else {
         print("Bad URL: \(urlString)")
         return
     }
     
     do {
         let (data, _) = try await URLSession.shared.data(from: url)
         let items = try JSONDecoder().decode(Result.self, from: data)
         pages = items.query.pages.values.sorted()
         loadingState = .loaded
     } catch {
         loadingState = .failed
     }
     
 }
 
 
 */
