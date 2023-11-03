//
//  PlantCollectionViewController.swift
//  PlantSrore
//
//  Created by Buba on 15.10.2023.
//

import UIKit

class PlantCollectionViewController: UICollectionViewController {
    private var viewModel: PlantCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchPlants { [unowned self] in
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlantCollectionViewModel()
        setupNavigationBar()
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: "\(PlantCell.self)")
        collectionView.backgroundColor = .backgroundGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlants { [unowned self] in
            collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PlantCell.self)", for: indexPath) as? PlantCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getPlantCellViewModel(at: indexPath)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let plantDetailsViewModel = viewModel.getPlantDetailsViewModel(at: indexPath)
        let detailVC = PlantDetailsViewController()
        detailVC.viewModel = plantDetailsViewModel
        navigationController?.pushViewController(detailVC, animated: true)
        return true
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = createCustomTitelView(titel: "PLANT STORE")
    }
}
