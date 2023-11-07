//
//  FavoritesViewModel.swift
//  PlantSrore
//
//  Created by Buba on 07.11.2023.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func fetchPlants(complition: @escaping() -> Void)
    func numberOfItems() -> Int
    func getFavoriteCellViewModel(at indexPath: IndexPath) -> FavoriteCellViewModelProtocol
}


final class FavoritesViewModel: FavoritesViewModelProtocol {
    private let data = DataManager.shared
    private var plants: [Plant] = []
    
    func fetchPlants(complition: @escaping () -> Void) {
        plants = data.favorite
        complition()
    }
    
    func numberOfItems() -> Int {
        plants.count
    }
    
    func getFavoriteCellViewModel(at indexPath: IndexPath) -> FavoriteCellViewModelProtocol {
        FavoriteCellViewModel(plant: plants[indexPath.item])
    }
}
