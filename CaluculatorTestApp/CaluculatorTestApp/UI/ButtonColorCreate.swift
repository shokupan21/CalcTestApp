//
//  ButtonColorCreate.swift
//  CaluculatorTestApp
//
//  Created by 前田 悟志 (Maeda Satoshi) on 2022/02/26.
//

import UIKit

func createImageFromUIColor(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
    // 1x1のbitmapを作成
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    // bitmapを塗りつぶし
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    
    // UIImageに変換
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let imageView = UIImageView(image:image)
    
    let rect2:CGRect = CGRect(x:0, y:0,
                              width: width, height: height)
    
    imageView.frame = rect2
    
    imageView.center = CGPoint(x:width/2, y:height/2)
    
    return imageView.convertToImage()
    
}

public extension UIImageView {
    func convertToImage() -> UIImage {
        let imageRenderer = UIGraphicsImageRenderer.init(size: bounds.size)
        return imageRenderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
