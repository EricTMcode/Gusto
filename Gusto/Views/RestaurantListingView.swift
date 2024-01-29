//
//  RestaurantListingView.swift
//  Gusto
//
//  Created by Eric on 29/01/2024.
//

import SwiftData
import SwiftUI

struct RestaurantListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Restaurant.priceRating, order: .reverse),
        SortDescriptor(\Restaurant.name)
    ]) var restaurants: [Restaurant]
    var body: some View {
        List {
            ForEach(restaurants) { restaurant in
                NavigationLink(value: restaurant) {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                        
                        HStack(spacing: 30) {
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                Text(String(restaurant.priceRating))
                            }
                            
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                Text(String(restaurant.qualityRating))
                            }
                            
                            HStack {
                                Image(systemName: "bolt")
                                Text(String(restaurant.speedRating))
                            }
                        }
                    }
                }
            }
            .onDelete(perform: deleteRestaurants)
        }
    }
    
    init(sort: SortDescriptor<Restaurant>, searchString: String = "") {
        _restaurants = Query(filter: #Predicate {
            if searchString.isEmpty {
                true
            } else {
                $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteRestaurants(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = restaurants[item]
            modelContext.delete(object)
        }
    }
}

#Preview {
    RestaurantListingView(sort: SortDescriptor(\Restaurant.name))
}
