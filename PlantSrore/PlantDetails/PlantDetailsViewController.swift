//
//  PlantDetailsViewController.swift
//  PlantSrore
//
//  Created by Buba on 17.10.2023.
//

import UIKit
import SnapKit

final class PlantDetailsViewController: UIViewController {
    var viewModel: PlantDetailsViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { [weak self] viewModel in
                self?.setFavoriteStatus(viewModel.isFavorite)
            }
            navigationItem.title = viewModel.name
            imageView.image = UIImage(named: viewModel.imageName)
            nameLabel.text = viewModel.name
            priceLabel.text = viewModel.price
            descriptionTextView.text = viewModel.description
        }
    }
    
    private let imageView = UIImageView()
    private let favoriteBtn = UIButton()
    private let backView = UIView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private metods
extension PlantDetailsViewController {
    private func setupUI() {
        view.backgroundColor = .backgroundGray
        
        imageView.contentMode = .scaleAspectFit
        
        backView.backgroundColor = .tabbarGrayItem
        backView.layer.cornerRadius = 50
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        nameLabel.numberOfLines = 0
        
        priceLabel.font = .systemFont(ofSize: 15)
        
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.isEditable = false
        
        favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteBtn.setPreferredSymbolConfiguration(.init(font: .systemFont(ofSize: 50)), forImageIn: .normal)
        favoriteBtn.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
        setFavoriteStatus(viewModel.isFavorite)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        view.addSubview(imageView)
        view.addSubview(favoriteBtn)
        view.addSubview(backView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionTextView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view).inset(view.bounds.height / 2)
        }
        
        favoriteBtn.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(40)
            make.trailing.equalTo(imageView.snp.trailing).offset(-16)
            make.bottom.equalTo(imageView.snp.bottom).offset(-16)
        }
        
        backView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
    private func setFavoriteStatus(_ status: Bool) {
        favoriteBtn.tintColor = status ? .red : .gray
    }
    
    @objc private func favoriteBtnPressed() {
        viewModel.favoriteBtnPressed()
    }
}
