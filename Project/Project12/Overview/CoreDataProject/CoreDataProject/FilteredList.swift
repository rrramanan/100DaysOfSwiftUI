//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ramanan on 15/12/22.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content:(T) -> Content
    
    enum PredicateValues { //challenge
        case beginsWith
        case contains
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    //challenge
    init(filterKey: String, sort: [SortDescriptor<T>] ,predicateValue: PredicateValues ,filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sort, predicate: NSPredicate(format:"%K \(predicateValue) %@",filterKey,filterValue))
        self.content = content
    }
}



/*
 
 @FetchRequest var fetchRequest: FetchedResults<Singer>
 
 var body: some View {
     List(fetchRequest, id: \.self) { singer in
         Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
     }
 }
 
 init(filter: String) {
    _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format:"lastName BEGINSWITH %@",filter))
 }
 
 
 */


//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//            .preferredColorScheme(.dark)
//    }
//}
