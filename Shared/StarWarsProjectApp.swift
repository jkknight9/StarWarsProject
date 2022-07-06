//
//  StarWarsProjectApp.swift
//  Shared
//
//  Created by Jack Knight on 7/5/22.
//

import SwiftUI

@main
struct StarWarsApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
