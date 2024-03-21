//
//  Onboarding.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/19/24.
//

import SwiftUI

let kFirstName = "firstName"
let kLastName = "lastName"
let kEmail = "email"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var email:String = ""
    @State var isLoggedIn: Bool = false
    
    func register() -> Void {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.emailAddress) // Set text content type to emailAddress
                    .autocapitalization(.none) // Turn off auto-capitalization
                    .keyboardType(.emailAddress) // Set keyboard type to emailAddress
                    .padding()
                
                Button("Register", action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        // Optional: Add email validation if needed
                        
                        // Store user details in UserDefaults
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    } else {
                        
                    }
                })
            }
            .onAppear(perform: {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            })
            .padding()
        }
    }
}

#Preview {
    Onboarding()
}
