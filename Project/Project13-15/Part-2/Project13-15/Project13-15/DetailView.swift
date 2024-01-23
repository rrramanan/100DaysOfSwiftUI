//
//  DetailView.swift
//  Project13-15
//
//  Created by Ramanan on 24/01/23.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var user: UIImage
    var userMapData: Location
    
    //var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        VStack {
            //[Location(id: UUID(), name: "", latitude: 50, longitude: 50)]
            Map(coordinateRegion: Binding<MKCoordinateRegion>.constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userMapData.latitude, longitude: userMapData.longitude), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))), annotationItems: [userMapData]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(Circle())
                }
            }
            
            Image(uiImage: user)
                .resizable()
            .scaledToFit()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: UIImage(), userMapData: Location.example)
            .preferredColorScheme(.dark)
    }
}
