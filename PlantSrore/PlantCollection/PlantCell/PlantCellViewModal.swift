//
//  PlantCellViewModal.swift
//  PlantSrore
//
//  Created by Buba on 25.10.2023.
//

protocol PlantCellViewModalProtocol {
    var imageName: String { get }
    var amount: Int { get }
    var amountIsZero: (() -> Void)? { get set }
    init(plant: Plant)
    func updatePlant()
    func cartBtnDidPress(complition: (@escaping(Int) -> Void))
    func addBtnDidPress(complition: (@escaping(Int) -> Void))
    func cutBtnDidPress(complition: (@escaping(Int) -> Void))
    func amountIsNotZero(complition: (@escaping(Int) -> Void))
}

final class PlantCellViewModal: PlantCellViewModalProtocol {
    var imageName: String {
        plant.imageName
    }
    
    var amount: Int {
        plant.amount
    }
    
    var amountIsZero: (() -> Void)?
    
    private var plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    func updatePlant() {
        guard let currentPlant = DataManager.shared.getPlant(id: plant.id) else { return }
        plant = currentPlant
    }
    
    func cartBtnDidPress(complition: @escaping ((Int) -> Void)) {
        DataManager.shared.changeAmount(for: plant.id, calculate: .plus)
        updatePlant()
        complition(plant.amount)
    }
    
    func addBtnDidPress(complition: @escaping ((Int) -> Void)) {
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
    
    func amountIsNotZero(complition: @escaping ((Int) -> Void)) {
        if amount > 0 {
            updatePlant()
            complition(plant.amount)
        }
    }
}
