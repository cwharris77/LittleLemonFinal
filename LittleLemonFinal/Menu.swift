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
            Header()
            
            VStack {
                Hero()

                HStack {
                    TextField("", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
            }
                .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                .padding(.bottom, 20)
            
            HStack() {
                Spacer()
                CategoriesButtons()
                Spacer()
            }
            
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
