//
//  FilteredLIst.swift
//  CoreDateProject
//
//  Created by Raymond Chen on 10/22/21.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    
    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

struct FilteredLIst_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "", filterValue: "") { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
