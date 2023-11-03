//
//  DataManager.swift
//  PlantSrore
//
//  Created by Buba on 24.10.2023.
//

import Foundation

enum Counter {
    case plus
    case minus
}

final class DataManager {
    static let shared = DataManager()
    
    var catalog: [Plant] {
        return data
    }
    
    var cart: [Plant] {
        data.filter { $0.amount > 0 }
    }
    
    private var data = Plant.getPlants()
    
    private init() {}
    
    func getPlant(id: String) -> Plant? {
        guard let index = data.firstIndex(where: { $0.id == id }) else { return nil}
        return data[index]
    }
    
    func setFavoriteStatus(for id: String) {
        guard let index = data.firstIndex(where: { $0.id == id }) else { return }
        data[index].isFavorite.toggle()
    }
    
    func changeAmount(for id: String, calculate: Counter) {
        guard let index = data.firstIndex(where: { $0.id == id }) else { return }
        switch calculate {
        case .plus:
            data[index].amount += 1
        case .minus:
            data[index].amount -= 1
        }
    }
}
