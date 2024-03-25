//
//  CategoriesButtons.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/25/24.
//

import SwiftUI

struct CategoriesButtons: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Text("Starters")
                    .padding(6)
            })
            .background(Color(hex: "edefee"))
            .foregroundColor(Color(hex: "495E57"))
            .cornerRadius(10)
            
            Button(action: {
                
            }, label: {
                Text("Mains")
                    .padding(6)
            })
            .background(Color(hex: "edefee"))
            .foregroundColor(Color(hex: "495E57"))
            .cornerRadius(10)
            
            Button(action: {
                
            }, label: {
                Text("Desserts")
                    .padding(6)
            })
            .background(Color(hex: "edefee"))
            .foregroundColor(Color(hex: "495E57"))
            .cornerRadius(10)
            
            Button(action: {
                
            }, label: {
                Text("Drinks")
                    .padding(6)
            })
            .background(Color(hex: "edefee"))
            .foregroundColor(Color(hex: "495E57"))
            .cornerRadius(10)
            
            
        }
    }
}

#Preview {
    CategoriesButtons()
}
