//
//  CartViewModel.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import Foundation

protocol CartTableViewModelProtocol {
    var cartIsEmpty: Bool { get }
    func fetchPlants(complition: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCartCellViewModel(at indexPath: IndexPath) -> CartCellViewModelProtocol
    func makeOrder()
    func emptyTheTrash()
}

final class CartTableViewModel: CartTableViewModelProtocol {
    var cartIsEmpty: Bool {
        plants.isEmpty
    }
    private let data = DataManager.shared
    private var plants: [Plant] = []
    
    func fetchPlants(complition: @escaping () -> Void) {
        plants = data.cart
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
    
    func makeOrder() {
        data.clearCart()
    }
    
    func emptyTheTrash() {
        if !data.cart.isEmpty {
            data.clearCart()
        }
    }
}
