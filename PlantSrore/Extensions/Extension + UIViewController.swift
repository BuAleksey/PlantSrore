//
//  Extension + UIViewController.swift
//  PlantSrore
//
//  Created by Buba on 31.10.2023.
//

import UIKit

extension UIViewController {
    func createCustomTitelView(titel: String) -> UIView {
        let view = UIView()
        view.frame = .infinite
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.macro")
        imageView.frame = CGRect(x: 0, y: 12, width: 20, height: 20)
        imageView.tintColor = .tabbarGreenItem
        view.addSubview(imageView)
        
        let titelLabel = UILabel()
        titelLabel.text = titel
        titelLabel.frame = CGRect(x: 24, y: 12, width: 115, height: 20)
        titelLabel.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(titelLabel)
        
        return view
    }
}
