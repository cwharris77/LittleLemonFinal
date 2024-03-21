//
//  LittleLemonFinalApp.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/12/24.
//

import SwiftUI

@main
struct LittleLemonFinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
