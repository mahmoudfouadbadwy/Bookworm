//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mahmoud Fouad on 8/6/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
             BooksView()
                .environment(\.managedObjectContext,
                             persistenceController.container.viewContext)
        }
    }
}
