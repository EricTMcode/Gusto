//
//  Restaurant.swift
//  Gusto
//
//  Created by Eric on 29/01/2024.
//

import Foundation
import SwiftData

@Model
class Restaurant {
    var name: String
    var priceRating: Int
    var qualityRating: Int
    var speedRating: Int
    @Relationship(deleteRule: .cascade) var dishes: [Dish]
    
    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
        self.dishes = []
    }
}
