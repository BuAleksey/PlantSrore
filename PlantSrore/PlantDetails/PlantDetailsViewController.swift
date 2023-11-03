//
//  PlantDetailsViewController.swift
//  PlantSrore
//
//  Created by Buba on 17.10.2023.
//

import UIKit
import SnapKit

class PlantDetailsViewController: UIViewController {
    var viewModel: PlantDetailsViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { [weak self] viewModel in
                self?.setFavoriteStatus(viewModel.isFavorite)
            }
            imageView.image = UIImage(named: viewModel.imageName)
            nameLabel.text = viewModel.name
            priceLabel.text = viewModel.price
        }
    }
    let imageView = UIImageView()
    let favoriteBtn = UIButton()
    let backView = UIView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Plant"
        
        view.backgroundColor = .backgroundGray
        
        imageView.contentMode = .scaleAspectFit
        
        backView.backgroundColor = .tabbarGrayItem
        backView.layer.cornerRadius = 20
        
        nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        priceLabel.font = .systemFont(ofSize: 20)
        
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
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view).inset(view.bounds.height / 2)
        }
        
        favoriteBtn.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(40)
            $0.trailing.equalTo(imageView.snp.trailing).offset(-16)
            $0.bottom.equalTo(imageView.snp.bottom).offset(-16)
        }
        
        backView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view)
            $0.top.equalTo(imageView.snp.bottom).offset(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func favoriteBtnPressed() {
        viewModel.favoriteBtnPressed()
    }
    
    private func setFavoriteStatus(_ status: Bool) {
        favoriteBtn.tintColor = status ? .red : .gray
    }
}
