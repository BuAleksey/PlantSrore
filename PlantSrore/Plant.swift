//
//  Plant.swift
//  PlantSrore
//
//  Created by Buba on 15.10.2023.
//

import Foundation

struct Plant {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let price: Double
    let description: String
    var isFavorite = false
    var amount = 0
    
    static func getPlants() -> [Plant] {
        [
        Plant(name: "Ficus", imageName: "plant", price: 434, description: ""),
        Plant(name: "Palma", imageName: "plant1", price: 312.99, description: ""),
        Plant(name: "Hyinya", imageName: "plant2", price: 34, description: ""),
        Plant(name: "Hyinya", imageName: "plant3", price: 3453, description: ""),
        Plant(name: "Hyinya", imageName: "plant1", price: 56, description: ""),
        Plant(name: "Ficus", imageName: "plant2", price: 676.66, description: ""),
        Plant(name: "Palma", imageName: "plant3", price: 4553.3, description: ""),
        Plant(name: "Hyinya", imageName: "plant", price: 45.9, description: ""),
        Plant(name: "Palma", imageName: "plant", price: 4324, description: ""),
        Plant(name: "Ficus", imageName: "plant2", price: 34, description: ""),
        Plant(name: "Palma", imageName: "plant1", price: 657, description: ""),
        Plant(name: "Ficus", imageName: "plant3", price: 896.78, description: ""),
        Plant(name: "Palma", imageName: "plant1", price: 43, description: ""),
        Plant(name: "Palma", imageName: "plant2", price: 345, description: ""),
        Plant(name: "Palma", imageName: "plant", price: 4565.56, description: ""),
        Plant(name: "Palma", imageName: "plant", price: 6767, description: "")
        ]
    }
}
