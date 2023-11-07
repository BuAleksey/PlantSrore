//
//  FavoriteCellViewModel.swift
//  PlantSrore
//
//  Created by Buba on 07.11.2023.
//

import Foundation

protocol FavoriteCellViewModelProtocol {
    var name: String { get }
    var imageName: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((FavoriteCellViewModelProtocol) -> Void)? { get set }
    init(plant: Plant)
    func favoriteBtnPressed()
}

final class FavoriteCellViewModel: FavoriteCellViewModelProtocol {
    var name: String {
        plant.name
    }
    var imageName: String {
        plant.imageName
    }
    var isFavorite: Bool {
        get {
            plant.isFavorite
        } set {
            plant.isFavorite.toggle()
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((FavoriteCellViewModelProtocol) -> Void)?
    
    private let data = DataManager.shared
    private var plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    func favoriteBtnPressed() {
        isFavorite.toggle()
        DataManager.shared.setFavoriteStatus(for: plant.id)
    }
}
