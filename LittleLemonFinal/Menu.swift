//
//  Menu.swift
//  LittleLemonFinal
//
//  Created by Cooper Harris on 3/20/24.
//

import SwiftUI

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
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("This app is for the Little Lemon restaurant")
            
            TextField("Search Menu", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .multilineTextAlignment(.center)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "") \(dish.price ?? "")")
                            let url = URL(string: dish.image ?? "")
                            AsyncImage(url: url)
                                .frame(width: 200, height: 200)
                        }
                    }
                }
            }
            
        }
        .padding()
        .onAppear() {
            getMenuData()
        }
    }
}

#Preview {
    Menu()
}
