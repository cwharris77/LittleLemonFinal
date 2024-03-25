//
//  Home.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/20/24.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem { Label("Menu", systemImage: "list.dash")}
            UserProfile()
                .tabItem { Label("Profile", systemImage: "square.and.pencil")}
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
