//
//  PlantCollectionViewModel.swift
//  PlantSrore
//
//  Created by Buba on 25.10.2023.
//

import Foundation

protocol PlantCollectionViewModelProtocol {
    var totalSum: Double { get }
    var isFreeDelivery: Bool { get }
    func fetchPlants(complition: @escaping() -> Void)
    func numberOfItems() -> Int
    func getPlantCellViewModel(at indexPath: IndexPath) -> PlantCellViewModalProtocol
    func getPlantDetailsViewModel(at indexPath: IndexPath) -> PlantDetailsViewModelProtocol
    func validateFreeDelivery() -> String
    func calculateTotalSum() -> String
}

final class PlantCollectionViewModel: PlantCollectionViewModelProtocol {
    var totalSum: Double {
        data.totalSum
    }
    var isFreeDelivery: Bool {
        data.freeDeliveryMinSum <= data.totalSum
    }
    
    private let data = DataManager.shared
    private var plants: [Plant] = []
    
    func fetchPlants(complition: @escaping () -> Void) {
        plants = data.catalog
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
    
    func validateFreeDelivery() -> String {
        let deltaSum = data.freeDeliveryMinSum - DataManager.shared.totalSum
        let text = deltaSum > 0 ? "\(deltaSum)₽ before free delivery" : "Delivery is free"
        return text
    }
    
    func calculateTotalSum() -> String {
        let sum = data.calculateTotalSum()
        let sumString = ("\(String(sum))₽")
        return sumString
    }
}
