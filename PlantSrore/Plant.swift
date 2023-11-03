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
    let pice: Double
    let description: String
    var isFavorite = false
    var amount = 0
    
    static func getPlants() -> [Plant] {
        [
        Plant(name: "Ficus", imageName: "plant", pice: 434, description: ""),
        Plant(name: "Palma", imageName: "plant1", pice: 312.99, description: ""),
        Plant(name: "Hyinya", imageName: "plant2", pice: 34, description: ""),
        Plant(name: "Hyinya", imageName: "plant3", pice: 3453, description: ""),
        Plant(name: "Hyinya", imageName: "plant1", pice: 56, description: ""),
        Plant(name: "Ficus", imageName: "plant2", pice: 676.66, description: ""),
        Plant(name: "Palma", imageName: "plant3", pice: 4553.3, description: ""),
        Plant(name: "Hyinya", imageName: "plant", pice: 45.9, description: ""),
        Plant(name: "Palma", imageName: "plant", pice: 4324, description: ""),
        Plant(name: "Ficus", imageName: "plant2", pice: 34, description: ""),
        Plant(name: "Palma", imageName: "plant1", pice: 657, description: ""),
        Plant(name: "Ficus", imageName: "plant3", pice: 896.78, description: ""),
        Plant(name: "Palma", imageName: "plant1", pice: 43, description: ""),
        Plant(name: "Palma", imageName: "plant2", pice: 345, description: ""),
        Plant(name: "Palma", imageName: "plant", pice: 4565.56, description: ""),
        Plant(name: "Palma", imageName: "plant", pice: 6767, description: "")
        ]
    }
}
