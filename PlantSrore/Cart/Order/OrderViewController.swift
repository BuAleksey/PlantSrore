//
//  OrderViewController.swift
//  PlantSrore
//
//  Created by Buba on 06.11.2023.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {
    private let label = UILabel()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true)
        }
    }
    
    private func setupUI() {        
        label.text = "Your order has been placed..."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        imageView.image = .delivery
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(label)
        view.addSubview(imageView)
        
        label.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
