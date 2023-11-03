//
//  CartCellViewModal.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import Foundation

protocol CartCellViewModelProtocol {
    var plantName: String { get }
    var amount: Int { get }
    var amountIsZero: (() -> Void)? { get set }
    var amountIsNotZero: (() -> Void)? { get set }
    init(plant: Plant)
    func updatePlant()
    func addBtnDidPress(complition: (@escaping(Int) -> Void))
    func cutBtnDidPress(complition: (@escaping(Int) -> Void))
}

final class CartCellViewModel: CartCellViewModelProtocol {
    var plantName: String {
        plant.name
    }
    
    var amount: Int {
        plant.amount
    }
    
    var amountIsZero: (() -> Void)?
    var amountIsNotZero: (() -> Void)?
        
    private var plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    func updatePlant() {
        guard let currentPlant = DataManager.shared.getPlant(id: plant.id) else { return }
        plant = currentPlant
    }
    
    func addBtnDidPress(complition: @escaping ((Int) -> Void)) {
        if amount == 0 {
            amountIsNotZero!()
        }
        DataManager.shared.changeAmount(for: plant.id, calculate: .plus)
        updatePlant()
        complition(plant.amount)
    }
    
    func cutBtnDidPress(complition: @escaping ((Int) -> Void)) {
        if amount == 1 {
            amountIsZero!()
        }
        DataManager.shared.changeAmount(for: plant.id, calculate: .minus)
        updatePlant()
        complition(amount)
    }
}
