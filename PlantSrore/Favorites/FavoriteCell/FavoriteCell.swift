//
//  FavoriteCell.swift
//  PlantSrore
//
//  Created by Buba on 07.11.2023.
//

import UIKit
import SnapKit

final class FavoriteCell: UICollectionViewCell {
    var viewModel: FavoriteCellViewModelProtocol! {
        didSet {
            imageView.image = UIImage(named: viewModel.imageName)
            setFavoriteStatus(viewModel.isFavorite)
            nameLabel.text = viewModel.name
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                setFavoriteStatus(viewModel.isFavorite)
            }
        }
    }
    private let imageView = UIImageView()
    private let favoriteBtn = UIButton()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private metods
extension FavoriteCell {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.3
        
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteBtn.setPreferredSymbolConfiguration(.init(font: .systemFont(ofSize: 50)), forImageIn: .normal)
        favoriteBtn.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteBtn)
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 5, bottom: 100, right: 5))
        }
        
        favoriteBtn.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(40)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.width.equalTo(imageView.snp.width)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setFavoriteStatus(_ status: Bool) {
        favoriteBtn.tintColor = status ? .red : .gray
    }
    
    @objc private func favoriteBtnPressed() {
        viewModel.favoriteBtnPressed()
    }
}
