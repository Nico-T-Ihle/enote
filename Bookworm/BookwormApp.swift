//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Nico Ihle on 23.08.22.
//

import SwiftUI
import CoreData

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
