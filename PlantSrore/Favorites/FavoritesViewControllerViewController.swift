//
//  FavoritesViewController.swift
//  PlantSrore
//
//  Created by Buba on 17.10.2023.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var viewModel: FavoritesViewModelProtocol! {
        didSet {
            viewModel.fetchPlants { [unowned self] in
                collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlants { [unowned self] in
            collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCell.self)", for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.getFavoriteCellViewModel(at: indexPath)
        return cell
    }
}

//MARK: - Private metods
extension FavoritesViewController {
    private func setupUI() {
        view.backgroundColor = .backgroundGray
        configurateCollectionView()
        configurateNavigationBar()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configurateNavigationBar() {
        navigationItem.titleView = createCustomTitelView(titel: "FAVORITE")
    }
    
    private func configurateCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let widthItem = view.layer.bounds.width / 2 - 24
        let heightItem = widthItem + widthItem / 2
        layout.itemSize = .init(width: widthItem, height: heightItem)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .init(top: 16, left: 16, bottom: 40, right: 16)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: "\(FavoriteCell.self)")
    }
}
