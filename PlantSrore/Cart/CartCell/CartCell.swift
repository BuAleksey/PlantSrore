//
//  CartCell.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import UIKit
import SnapKit

final class CartCell: UITableViewCell {
    var viewModel: CartCellViewModelProtocol! {
        didSet {
            setupDefaulUI()
            viewModel.updatePlant()
            nameLabel.text = viewModel.plantName
            amountLabel.text = viewModel.amount
            viewModel.amountIsZero = { [unowned self] in
                cutBtn.isHidden = true
                backView.layer.opacity = 0.5
                backView.backgroundColor = .red
                addBtn.backgroundColor = .white
                addBtn.setTitleColor(.black, for: .normal)
            }
            viewModel.amountIsNotZero = { [unowned self] in
                setupDefaulUI()
            }
        }
    }
    
    private let backView = UIView()
    private let nameLabel = UILabel()
    private let cutBtn = UIButton(type: .system)
    private let amountLabel = UILabel()
    private let addBtn = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefaulUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private metods
extension CartCell {
    private func setupDefaulUI() {
        contentView.backgroundColor = .backgroundGray
        
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        backView.layer.opacity = 1

        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        cutBtn.setTitle("-", for: .normal)
        cutBtn.setTitleColor(.white, for: .normal)
        cutBtn.backgroundColor = .tabbarGreenItem
        cutBtn.layer.cornerRadius = 5
        cutBtn.addTarget(self, action: #selector(cutBtnPressed), for: .touchUpInside)
        cutBtn.isHidden = false
        
        amountLabel.textAlignment = .center
        
        addBtn.setTitle("+", for: .normal)
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.backgroundColor = .tabbarGreenItem
        addBtn.layer.cornerRadius = 5
        addBtn.addTarget(self, action: #selector(addBtnPressed), for: .touchUpInside)
        
        setupConstains()
    }
    
    private func setupConstains() {
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(cutBtn)
        backView.addSubview(amountLabel)
        backView.addSubview(addBtn)
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).offset(16)
            make.centerY.equalTo(backView.snp.centerY)
        }
        
        addBtn.snp.makeConstraints { make in
            make.trailing.equalTo(backView.snp.trailing).offset(-16)
            make.centerY.equalTo(backView.snp.centerY)
            make.width.equalTo(50)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addBtn.snp.leading).offset(-8)
            make.centerY.equalTo(backView.snp.centerY)
            make.width.equalTo(50)
        }
        
        cutBtn.snp.makeConstraints { make in
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8)
            make.centerY.equalTo(backView.snp.centerY)
            make.width.equalTo(50)
        }
    }
    
    @objc private func addBtnPressed() {
        viewModel.addBtnDidPress { [unowned self] amount in
            amountLabel.text = amount
        }
    }
    
    @objc private func cutBtnPressed() {
        viewModel.cutBtnDidPress { [unowned self] amount in
            amountLabel.text = amount
        }
    }
}
