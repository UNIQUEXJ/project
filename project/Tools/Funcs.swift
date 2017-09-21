//
//  Funcs.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//
import MBProgressHUD

func lj_setDefaulteInfo( statusStyle: UIStatusBarStyle? = .lightContent, ctr: UIViewController, titleColor: UIColor? = UIColor.gray, textColor: UIColor? = UIColor.gray,  bgColor: UIColor? = UIColor.white) {
    //    ctr.navigationController?.navigationBar.backgroundColor = bgColor
    ctr.navigationController?.navigationBar.setBackgroundImage(UIImage.lj_creatImageWithColor(bgColor), for: .default)
    UIApplication.shared.statusBarStyle = statusStyle!
    let bar = ctr.navigationController?.navigationBar
    let attr = [NSAttributedStringKey.foregroundColor: titleColor ?? UIColor.gray]
    bar?.titleTextAttributes = attr
    bar?.tintColor = textColor
}

func lj_loginView(_ isError: Bool = true) {
    let window = UIApplication.shared.keyWindow
    for item in (window?.subviews)! {
        item.removeFromSuperview()
    }
    window?.backgroundColor = UIColor.white
    window?.rootViewController = ViewController()
    if isError {
        MBProgressHUD.lj_showText(text: "登录过期")
    }
}


// MARK: 简单提示
/// 简单提示
func showAlertAction(hint : String?, viewCtr: UIViewController) {
    let alert = UIAlertController(title: "提示", message: hint, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(action)
    viewCtr.present(alert, animated: true, completion: nil)
}
// MARK: 给View设置不同角度圆角

/// <#Description#>
///
/// - Parameters:
///   - view: view
///   - size: CGSize
///   - rectCorners: let rectCorners: UIRectCorner = [.topLeft, .topRight]
func lj_settingRadioLayerMask(_ view: UIView, _ size: CGSize, _ rectCorners: UIRectCorner) {
    let maskLayer = CAShapeLayer()
    let maskFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    maskLayer.frame = maskFrame
    let maskPath = UIBezierPath(roundedRect: maskLayer.bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: 3, height: 3))
    maskLayer.path = maskPath.cgPath
    view.layer.mask = maskLayer
}
