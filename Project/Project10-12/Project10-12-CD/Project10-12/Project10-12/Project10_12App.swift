//
//  Project10_12App.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

@main
struct Project10_12App: App {
    @StateObject private var userClass = UserClass()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, userClass.container.viewContext)
        }
    }
}
