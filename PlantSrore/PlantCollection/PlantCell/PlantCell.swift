//
//  PlantCell.swift
//  PlantSrore
//
//  Created by Buba on 15.10.2023.
//

import UIKit
import SnapKit

final class PlantCell: UICollectionViewCell {
    var viewModel: PlantCellViewModalProtocol! {
        didSet {
            setupDefaultUI()
            viewModel.updatePlant()
            viewModel.amountIsNotZero { [unowned self] amount in
                amountLabel.text = amount
                setupSecondUI()
            }
            viewModel.amountIsZero = { [weak self] in
                self?.setupDefaultUI()
            }
            imageView.image = UIImage(named: viewModel.imageName)
            nameLabel.text = viewModel.name
            amountLabel.text = viewModel.amount
        }
    }
    weak var delegte: PlantStoreViewControllerDelegate?
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let cartBtn = UIButton(type: .system)
    private let addBtn = UIButton(type: .system)
    private let amountLabel = UILabel()
    private let cutBtn = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private metods
extension PlantCell {
    private func setupDefaultUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.3
        
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        cartBtn.backgroundColor = .tabbarGreenItem
        cartBtn.setTitle("Add to cart", for: .normal)
        cartBtn.setTitleColor(.white, for: .normal)
        cartBtn.layer.cornerRadius = 5
        cartBtn.isHidden = false
        cartBtn.addTarget(self, action: #selector(cartBtnPressed), for: .touchUpInside)
        
        setupFirstConstraint()
    }
    
    private func setupSecondUI() {
        cartBtn.isHidden = true
        
        addBtn.backgroundColor = .tabbarGreenItem
        addBtn.setTitle("+1", for: .normal)
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.layer.cornerRadius = 5
        addBtn.addTarget(self, action: #selector(addBtnPressed), for: .touchUpInside)
        
        amountLabel.textAlignment = .center
        
        cutBtn.backgroundColor = .tabbarGreenItem
        cutBtn.setTitle("-1", for: .normal)
        cutBtn.setTitleColor(.white, for: .normal)
        cutBtn.layer.cornerRadius = 5
        cutBtn.addTarget(self, action: #selector(cutBtnPressed), for: .touchUpInside)
        
        cartBtn.isHidden = true
        
        contentView.addSubview(addBtn)
        contentView.addSubview(amountLabel)
        contentView.addSubview(cutBtn)
        
        setupSecondConstraint()
    }
    
    private func setupFirstConstraint() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cartBtn)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 5, bottom: 70, right: 5))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.width.equalTo(imageView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        cartBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(150)
        }
    }
    
    private func setupSecondConstraint() {
        cutBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalTo(contentView.snp.centerX).offset(-50)
            make.width.equalTo(50)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(50)
        }
        
        addBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalTo(contentView.snp.centerX).offset(+50)
            make.width.equalTo(50)
        }
    }
    
    @objc private func cartBtnPressed() {
        viewModel.cartBtnDidPress { [unowned self] amount in
            setupSecondUI()
            amountLabel.text = amount
        }
        delegte?.updateDeliveryView()
    }
    
    @objc private func addBtnPressed() {
        viewModel.addBtnDidPress { [unowned self] amount in
            amountLabel.text = amount
        }
        delegte?.updateDeliveryView()
    }
    
    @objc private func cutBtnPressed() {
        viewModel.cutBtnDidPress { [unowned self] amount in
            amountLabel.text = amount
        }
        delegte?.updateDeliveryView()
    }
}

