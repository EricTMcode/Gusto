//
//  GustoApp.swift
//  Gusto
//
//  Created by Eric on 29/01/2024.
//

import SwiftData
import SwiftUI

@main
struct GustoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Restaurant.self)
    }
}
