//
//  BaseVC.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

protocol BaseVC {
    func setBaseDefaults()
}
extension BaseVC {
    func setBaseDefaults() {
        guard let vc = self as? UIViewController else {
            return
        }
        vc.automaticallyAdjustsScrollViewInsets = true
        let weight = CGFloat(arc4random_uniform(1000)) / 1000
        vc.view.backgroundColor = UIColor(hue: weight, saturation: 1, brightness: 1, alpha: 1)
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
