//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Ramanan on 18/01/23.
//

import Foundation

//extension ContentView {
    @MainActor class EditPageViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        @Published var location: Location?
        @Published var name: String
        @Published var description: String?
        
        @Published private var loadingState = LoadingState.loading
        @Published private var pages = [Page]()
        
        init(name: String, description: String,location: Location) {
            self.location = location
            
            _name = Published(initialValue: location.name)
            //self.description = description
        }
        
        
        // #4 -- Downloading data from Wikipedia
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location!.coordinate.latitude)%7C\(location!.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
      
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
//}


