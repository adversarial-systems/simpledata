//
//  simpledataApp.swift
//  simpledata
//
//  Created by user on 9/20/20.
//

import SwiftUI

@main
struct simpledataApp: App {
  
    let cloudContext = PersistentCloudKitContainer.persistentContainer.viewContext
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.managedObjectContext, self.cloudContext)
              .onDisappear(perform: {
                 PersistentCloudKitContainer.saveContext()
              })
        }
    }
}
