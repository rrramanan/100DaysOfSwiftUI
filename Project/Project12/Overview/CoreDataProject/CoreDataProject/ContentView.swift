//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ramanan on 14/12/22.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    var students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    // #5 -- Filtering @FetchRequest using NSPredicate
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format:"NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    //NSPredicate(format:"universe == 'Star Wars'")
    //NSPredicate(format:"universe == %@", "Star Wars")
    
    //NSPredicate(format:"name < %@", "F")
    //NSPredicate(format:"universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    
    //NSPredicate(format:"name BEGINSWITH %@", "E")
    //NSPredicate(format:"name BEGINSWITH %@", "e") // - case sensitive
    
    //NSPredicate(format:"name BEGINSWITH[c] %@", "e") // [c] -  makes case insensitive
    //NSPredicate(format:"name CONTAINS[c] %@", "e")
    
    
    // #6 --  Dynamically filtering @FetchRequest with SwiftUI
    
    @State private var lastNameFilter = "A"
    
    // #7 --   One-to-many relationships with Core Data, SwiftUI, and @FetchRequest
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    //@FetchRequest(sortDescriptors: [])
    
    var body: some View {
        
        
        /*
       // #1 ---  Why does \.self work for ForEach?
        List {
            /*
            ForEach([2, 4, 6, 8, 10], id: \.self) {
                Text("\($0) is even")
            }
            */
            ForEach(students, id: \.self) { student in
                Text("\(student.name)")
            }
        }
        */
        
        // #2 -- Creating NSManagedObject subclasses
        // ----  Created class manually ----
        
        // #3 -- Conditional saving of NSManagedObjectContext
        
        /*
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
        */
        
        // #4 -- Ensuring Core Data objects are unique using constraints
        /*
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        */
        
        // #5 -- Filtering @FetchRequest using NSPredicate
        
        /*
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
        */
        
        // #6 --  Dynamically filtering @FetchRequest with SwiftUI
        
    
        VStack {
            //FilteredList(filter: lastNameFilter)  //"BEGINSWITH"
            
            //Challenge
            FilteredList(filterKey: "lastName", sort: [SortDescriptor(\Singer.lastName)], predicateValue: .beginsWith, filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
        
        
        // #7 --   One-to-many relationships with Core Data, SwiftUI, and @FetchRequest
        /*
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add Exmaple") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? moc.save()
            }
            
            
        }
        */
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
