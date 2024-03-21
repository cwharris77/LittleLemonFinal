//
//  UserProfile.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/20/24.
//

import SwiftUI

struct UserProfile: View {
    let firstName: String? = UserDefaults.standard.string(forKey: "firstName")
    let lastName: String? = UserDefaults.standard.string(forKey: "lastName")
    let email: String? = UserDefaults.standard.string(forKey: "email")
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal Information")
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text(firstName ?? "First Name")
            Text(lastName ?? "Last Name")
            Text(email ?? "Email")
            
            Button("Logout") {
                UserDefaults.standard.setValue(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UserProfile()
}
