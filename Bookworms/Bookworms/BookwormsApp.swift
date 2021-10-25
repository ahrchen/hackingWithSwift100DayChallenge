//
//  BookwormsApp.swift
//  Bookworms
//
//  Created by Raymond Chen on 10/19/21.
//

import SwiftUI

@main
struct BookwormsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
