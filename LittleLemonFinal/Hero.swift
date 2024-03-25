//
//  Hero.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/25/24.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .font(.custom("MarkaziText-Medium", fixedSize: 35))
                        .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                        .padding(.leading, 20)
                    
                    HStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            Text("Chicago")
                                .font(.custom("MarkaziText-Medium", fixedSize: 40))
                                .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .padding([.leading], 20)
                            
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .padding(.horizontal, 20)
                        }
                        
                        Image("Hero image")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 125, maxHeight: 150)
                            .cornerRadius(20.0)
                            .padding([.trailing], 12)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 240)
        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
    }
       
}

#Preview {
    Hero()
}
