//
//  UIImage+UIImageView+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UIImageView {
    //  加圆角 UIImage不能为nil
    func lj_addCorner(radius: CGFloat) {
        self.image = self.image?.lj_drawRectWithRoundedCorner(radius: radius, self.bounds.size)
    }
}
extension UIImage {
    static func lj_creatImageWithColor(_ color: UIColor? = nil) -> UIImage {
        let contentWidth: CGFloat = 1
        let contentHeight: CGFloat = 1
        let rect = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight)
        UIGraphicsBeginImageContext(CGSize(width: contentWidth, height: contentHeight))
        let context = UIGraphicsGetCurrentContext()
        let color = color ?? UIColor.white
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return img
    }
    
    func lj_drawRectWithRoundedCorner(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        UIGraphicsGetCurrentContext()!.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners,
                                                            cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        UIGraphicsGetCurrentContext()?.clip()
        
        self.draw(in: rect)
        UIGraphicsGetCurrentContext()!.drawPath(using: .fillStroke)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext();
        return img
    }
    // 生成不变形的Image
    static func lj_resizable(_ imageName: String) -> UIImage {
        let img = UIImage(named: imageName)
        let w = (img?.size.width ?? 0) * 0.5
        let h = (img?.size.height ?? 0) * 0.5
        
        let newImage = img?.resizableImage(withCapInsets: UIEdgeInsets(top: h, left: w, bottom: h, right: w), resizingMode: .stretch)
        return newImage ?? UIImage()
    }
}
