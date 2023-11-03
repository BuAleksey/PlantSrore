//
//  CartCell.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import UIKit
import SnapKit

class CartCell: UITableViewCell {
    var viewModel: CartCellViewModelProtocol! {
        didSet {
            setupDefaulUI()
            viewModel.updatePlant()
            nameLabel.text = viewModel.plantName
            amountLabel.text = viewModel.amount.formatted()
            viewModel.amountIsZero = { [unowned self] in
                cutBtn.isHidden = true
                view.layer.opacity = 0.5
                view.backgroundColor = .red
                addBtn.backgroundColor = .white
                addBtn.setTitleColor(.black, for: .normal)
            }
            viewModel.amountIsNotZero = { [unowned self] in
                setupDefaulUI()
            }
        }
    }
    
    private let view = UIView()
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
    
    private func setupDefaulUI() {
        contentView.backgroundColor = .backgroundGray
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.opacity = 1
        
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
        contentView.addSubview(view)
        view.addSubview(nameLabel)
        view.addSubview(cutBtn)
        view.addSubview(amountLabel)
        view.addSubview(addBtn)
        
        view.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(8)
            make.height.equalToSuperview().offset(-10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(16)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        addBtn.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(50)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addBtn.snp.leading).offset(-8)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(50)
        }
        
        cutBtn.snp.makeConstraints { make in
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(50)
        }
    }
    
    @objc private func addBtnPressed() {
        viewModel.addBtnDidPress { [unowned self] amount in
            amountLabel.text = amount.formatted()
        }
    }
    
    @objc private func cutBtnPressed() {
        viewModel.cutBtnDidPress { [unowned self] amount in
            amountLabel.text = amount.formatted()
        }
    }
}
