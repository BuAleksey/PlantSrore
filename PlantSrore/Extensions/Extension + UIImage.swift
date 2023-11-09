//
//  Extension + UIImage.swift
//  PlantSrore
//
//  Created by Buba on 07.11.2023.
//

import UIKit

extension UIImage {
    static func resizeImage(_ image: UIImage, with size: CGSize = CGSize(width: 120, height: 120)) -> UIImage? {
        let imageSize = image.size
        
        let wigthRatio = size.width / imageSize.width
        let heightRatio = size.height / imageSize.height
        
        var newSize: CGSize
        if wigthRatio > heightRatio {
            newSize = CGSize(
                width: size.width * heightRatio,
                height: size.height * heightRatio)
        } else {
            newSize = CGSize(
                width: size.width * wigthRatio,
                height: size.height * wigthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        
        return newImage
    }
}
