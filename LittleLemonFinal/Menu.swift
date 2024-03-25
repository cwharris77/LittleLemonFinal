//
//  Menu.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/20/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: Double(red), green: Double(green), blue: Double(blue))
    }
}

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var dishes: FetchedResults<Dish>
    @State var searchText = ""
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let serverString:String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        let url = URL(string: serverString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                let decodedData = try? JSONDecoder().decode(MenuList.self, from: data)
                for menuItem in decodedData!.menu {
                    let newDish = Dish(context: viewContext)
                    newDish.title = menuItem.title
                    newDish.price = menuItem.price
                    newDish.category = menuItem.category
                }
                
                try? viewContext.save()
            } else {
                print("No data received")
            }
        }
        
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
            .background(Color.white)
            .padding(.trailing)
            .frame(height: 40)
            
            VStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "F4CE14"))
                    .padding()
                Text("Chicago")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.top, -35)
                
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Search Menu", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .background(Color(hex: "495e57"))
            
            Text("Order for Delivery!")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .padding()
            
            CategoriesButtons()
                .frame(width: 400)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "") \(dish.price ?? "")")
                            let url = URL(string: dish.image ?? "")
                            AsyncImage(url: url)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            
        }
        .onAppear() {
            getMenuData()
        }
    }
}

#Preview {
    Menu()
}
