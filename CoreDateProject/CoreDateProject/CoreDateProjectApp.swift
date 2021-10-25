//
//  CoreDateProjectApp.swift
//  CoreDateProject
//
//  Created by Raymond Chen on 10/21/21.
//

import CoreData
import SwiftUI

@main
struct CoreDateProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
