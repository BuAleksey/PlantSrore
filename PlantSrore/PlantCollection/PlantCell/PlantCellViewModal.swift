//
//  PlantCellViewModal.swift
//  PlantSrore
//
//  Created by Buba on 25.10.2023.
//

protocol PlantCellViewModalProtocol {
    var imageName: String { get }
    var name: String { get }
    var amount: String { get }
    var amountIsZero: (() -> Void)? { get set }
    init(plant: Plant)
    func updatePlant()
    func cartBtnDidPress(complition: (@escaping(String) -> Void))
    func addBtnDidPress(complition: (@escaping(String) -> Void))
    func cutBtnDidPress(complition: (@escaping(String) -> Void))
    func amountIsNotZero(complition: (@escaping(String) -> Void))
}

final class PlantCellViewModal: PlantCellViewModalProtocol {
    var imageName: String {
        plant.imageName
    }
    
    var name: String {
        plant.name
    }
    
    var amount: String {
        String(plant.amount)
    }
    
    var amountIsZero: (() -> Void)?
    
    private let data = DataManager.shared
    private var plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    func updatePlant() {
        guard let currentPlant = data.getPlant(id: plant.id) else { return }
        plant = currentPlant
    }
    
    func cartBtnDidPress(complition: @escaping ((String) -> Void)) {
        data.changeAmount(for: plant.id, calculate: .plus)
        updatePlant()
        complition(String(plant.amount))
    }
    
    func addBtnDidPress(complition: @escaping ((String) -> Void)) {
        data.changeAmount(for: plant.id, calculate: .plus)
        updatePlant()
        complition(String(plant.amount))
    }
    
    func cutBtnDidPress(complition: @escaping ((String) -> Void)) {
        if Int(amount) == 1 {
            amountIsZero!()
        }
        data.changeAmount(for: plant.id, calculate: .minus)
        updatePlant()
        complition(amount)
    }
    
    func amountIsNotZero(complition: @escaping ((String) -> Void)) {
        if Int(amount) ?? 0 > 0 {
            updatePlant()
            complition(String(plant.amount))
        }
    }
}
