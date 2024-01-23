//
//  AddView.swift
//  Project13-15
//
//  Created by Ramanan on 24/01/23.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String
    @State private var showPicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @ObservedObject var saveUser: UserClass
    //@State var user: userCollect
    @FocusState private var keyboardFocus: Bool
    let pathToSave = FileManager.documentsDirectory.appendingPathComponent("userlogs")
    let locationFetcher = LocationFetcher()
    
    var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    Button("Tap to upload a photo") {
                        showPicker.toggle()
                    }
            
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                }
                Spacer()
                HStack {
                    Text("Add Name:")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    TextField("Enter your name", text: $name)
                        .padding()
                        .focused($keyboardFocus)
                }
                
               // Map(coordinateRegion: $mapregion, annotationItems: , annotationContent: <#T##(Identifiable) -> MapAnnotationProtocol#>)
                
                
                
                Button("Start Tracking Location") {
                    self.locationFetcher.start()
                }

               Button("Read Location") {
                   if let location = self.locationFetcher.lastKnownLocation {
                       print("Your location is \(location)")
                    
                   } else {
                       print("Your location is unknown")
                   }
               }
                
                Spacer()
                Spacer()
            }
            .navigationTitle("Add View")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(disabled())
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        keyboardFocus = false
                    }
                }
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func save() {
        guard let inputImage = inputImage else { return }
        guard let imageData = inputImage.jpegData(compressionQuality: 0.8) else { return }
        
        let location = Location.example
        let item = User(id: UUID(), name: name, image: imageData, userMap: location)
        saveUser.userData.append(item)
        
        do {
            let data = try JSONEncoder().encode(saveUser.userData)
            try data.write(to: saveUser.path, options: [.atomic , .completeFileProtection])
        } catch {
            print("unable to save data")
        }
    }
    
    func disabled() -> Bool {
        if inputImage != nil && name.count > 0 {
            return false
        } else {
            return true
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
       AddView(name: "", saveUser: UserClass())
        //AddView(name: "Test", user: userCollect())
            .preferredColorScheme(.dark)
    }
}
