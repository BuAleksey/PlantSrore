//
//  CartViewModel.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import Foundation

protocol CartTableViewModelProtocol {
    func fetchPlants(complition: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCartCellViewModel(at indexPath: IndexPath) -> CartCellViewModelProtocol
}

final class CartTableViewModel: CartTableViewModelProtocol {
    private var plants: [Plant] = []
    
    func fetchPlants(complition: @escaping () -> Void) {
        plants = DataManager.shared.cart
        complition()
    }
    
    func numberOfRows() -> Int {
        plants.count
    }
    
    func getCartCellViewModel(at indexPath: IndexPath) -> CartCellViewModelProtocol {
        CartCellViewModel(plant: plants[indexPath.row])
    }
    
    func reloadTab(complition: @escaping () -> Void) {
        complition()
    }
}
