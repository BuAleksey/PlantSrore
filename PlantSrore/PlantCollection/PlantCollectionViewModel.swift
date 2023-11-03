//
//  PlantCollectionViewModel.swift
//  PlantSrore
//
//  Created by Buba on 25.10.2023.
//

import Foundation

protocol PlantCollectionViewModelProtocol {
    func fetchPlants(complition: @escaping() -> Void)
    func numberOfItems() -> Int
    func getPlantCellViewModel(at indexPath: IndexPath) -> PlantCellViewModalProtocol
    func getPlantDetailsViewModel(at indexPath: IndexPath) -> PlantDetailsViewModelProtocol
}

final class PlantCollectionViewModel: PlantCollectionViewModelProtocol {
    private var plants: [Plant] = []
    
    func fetchPlants(complition: @escaping () -> Void) {
        plants = DataManager.shared.catalog
        complition()
    }
    
    func numberOfItems() -> Int {
        plants.count 
    }
    
    func getPlantCellViewModel(at indexPath: IndexPath) -> PlantCellViewModalProtocol {
        PlantCellViewModal(plant: plants[indexPath.item])
    }
    
    func getPlantDetailsViewModel(at indexPath: IndexPath) -> PlantDetailsViewModelProtocol {
        PlantDetailsViewModel(plant: plants[indexPath.item])
    }
}
