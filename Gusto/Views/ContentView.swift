//
//  ContentView.swift
//  Gusto
//
//  Created by Eric on 29/01/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = SortDescriptor(\Restaurant.name)
    @State private var navPath = [Restaurant]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $navPath) {
            RestaurantListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Gusto")
                .navigationDestination(for: Restaurant.self) { restaurant in
                    EditRestaurantView(restaurant: restaurant)
                }
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    
                    Button(action: addNewRestaurant) {
                        Label("Add new restaurant", systemImage: "plus")
                    }
                    
                    Menu("Sort") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Restaurant.name))
                            
                            Text("Price")
                                .tag(SortDescriptor(\Restaurant.priceRating, order: .reverse))
                            
                            Text("Quality")
                                .tag(SortDescriptor(\Restaurant.qualityRating, order: .reverse))
                            
                            Text("Speed")
                                .tag(SortDescriptor(\Restaurant.speedRating, order: .reverse))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addSamples() {
        try? modelContext.delete(model: Restaurant.self)
        
        let a = Restaurant(name: "Wok this Way", priceRating: 5, qualityRating: 4, speedRating: 3)
        let b = Restaurant(name: "Thyme Square", priceRating: 3, qualityRating: 4, speedRating: 2)
        let c = Restaurant(name: "Pasta la Vista", priceRating: 4, qualityRating: 4, speedRating: 2)
        let d = Restaurant(name: "Life of Pie", priceRating: 3, qualityRating: 4, speedRating: 5)
        let e = Restaurant(name: "Lord of the Wings", priceRating: 5, qualityRating: 2, speedRating: 5)
        
        modelContext.insert(a)
        modelContext.insert(b)
        modelContext.insert(c)
        modelContext.insert(d)
        modelContext.insert(e)
    }
    
    
    
    func addNewRestaurant() {
        let restaurant = Restaurant(name: "New Restaurant", priceRating: 3, qualityRating: 3, speedRating: 3)
        modelContext.insert(restaurant)
        
        navPath = [restaurant]
    }
}

#Preview {
    ContentView()
}
