//
//  PlantCollectionViewController.swift
//  PlantSrore
//
//  Created by Buba on 15.10.2023.
//

import UIKit

protocol PlantStoreViewControllerDelegate {
    func updateDeliveryView()
}

class PlantStoreViewController: UIViewController {
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let deliveryView = UIView()
    private let delyveryLabel = UILabel()
    private let totalSumLabel = UILabel()
    private var viewModel: PlantStoreViewModelProtocol! {
        didSet {
            viewModel.fetchPlants { [unowned self] in
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlantStoreViewModel()
        setupUI()
        updateCartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlants { [unowned self] in
            collectionView.reloadData()
        }
        updateCartView()
    }
}

// MARK: - UICollectionView
extension PlantStoreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PlantCell.self)", for: indexPath) as? PlantCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getPlantCellViewModel(at: indexPath)
        cell.delegte = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let plantDetailsViewModel = viewModel.getPlantDetailsViewModel(at: indexPath)
        let detailVC = PlantDetailsViewController()
        detailVC.viewModel = plantDetailsViewModel
        navigationController?.pushViewController(detailVC, animated: true)
        return true
    }
}

// MARK: - Private metods
extension PlantStoreViewController {
    private func setupUI() {
        collectionView.backgroundColor = .backgroundGray
        configurateCollectionView()
        configurNavigationBar()
        
        deliveryView.layer.cornerRadius = 10
        
        delyveryLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        totalSumLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        view.addSubview(collectionView)
        view.addSubview(deliveryView)
        deliveryView.addSubview(delyveryLabel)
        deliveryView.addSubview(totalSumLabel)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deliveryView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(view.bounds.width - 80)
            make.bottom.equalToSuperview().offset(-110)
        }
        
        delyveryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(deliveryView.snp.centerY)
        }
        
        totalSumLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(deliveryView.snp.centerY)
        }
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
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: "\(PlantCell.self)")
    }
    
    private func configurNavigationBar() {
        navigationItem.titleView = createCustomTitelView(titel: "PLANT STORE")
    }
    
    private func updateCartView() {
        deliveryView.backgroundColor = viewModel.isFreeDelivery
        ? .tabbarGreenItem
        : .white
        
        delyveryLabel.text = viewModel.validateFreeDelivery()
        totalSumLabel.text = viewModel.calculateTotalSum()
        deliveryView.isHidden = viewModel.totalSum == 0
    }
}

extension PlantStoreViewController: PlantStoreViewControllerDelegate {
    func updateDeliveryView() {
        updateCartView()
    }
}
