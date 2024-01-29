//
//  EditRestaurantView.swift
//  Gusto
//
//  Created by Eric on 29/01/2024.
//

import SwiftData
import SwiftUI

struct EditRestaurantView: View {
    @Bindable var restaurant: Restaurant
    
    @State private var showingAddDishAlert = false
    @State private var dishName = ""
    @State private var dishReview = ""
    
    var body: some View {
        Form {
            TextField("Name of restaurant", text: $restaurant.name)
            
            Section("Ratings") {
                Picker("Price", selection: $restaurant.priceRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
                
                Picker("Quality", selection: $restaurant.qualityRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
                
                Picker("Speed", selection: $restaurant.speedRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }
            }
            
            Section {
                ForEach(restaurant.dishes) { dish in
                    Text(dish.name)
                }
            }
        }
        .toolbar {
            Button("Add Dish") {
                showingAddDishAlert.toggle()
            }
        }
        .alert("Add a new dish", isPresented: $showingAddDishAlert) {
            TextField("Dish name", text: $dishName)
            TextField("Your review", text: $dishReview)
            
            Button("OK", action: createDish)
            Button("Cancel", role: .cancel) {}
        }
    }
    
    func createDish() {
        let dish = Dish(name: dishName, review: dishReview)
        restaurant.dishes.append(dish)
        dishName = ""
        dishReview = ""
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self, configurations: config)
    
    let restaurant = Restaurant(name: "Bun Voyage", priceRating: 1, qualityRating: 2, speedRating: 3)
    
    return EditRestaurantView(restaurant: restaurant)
        .modelContainer(container)
}
