//
//  PlantDetailsViewModel.swift
//  PlantSrore
//
//  Created by Buba on 24.10.2023.
//

import Foundation

protocol PlantDetailsViewModelProtocol {
    var name: String { get }
    var imageName: String { get }
    var price: String { get }
    var description: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((PlantDetailsViewModelProtocol) -> Void)? { get set }
    init(plant: Plant)
    func favoriteBtnPressed()
}

final class PlantDetailsViewModel: PlantDetailsViewModelProtocol {
    var name: String {
        plant.name
    }
    var imageName: String {
        plant.imageName
    }
    var price: String {
        String(plant.price.formatted()) + "₽"
    }
    var description: String {
        plant.description
    }
    var isFavorite: Bool {
        get {
            plant.isFavorite
        } set {
            plant.isFavorite.toggle()
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((PlantDetailsViewModelProtocol) -> Void)?
    
    private var plant: Plant 
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    func favoriteBtnPressed() {
        isFavorite.toggle()
        DataManager.shared.setFavoriteStatus(for: plant.id)
    }
}
