//
//  LJTabbarController.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

class LJTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension LJTabBarController {
    override func viewWillAppear(_ animated: Bool) {
        //        UIApplication.shared.statusBarStyle = .lightContent
    }
    fileprivate func setUI() {
        addController("设备列表", "icon_device", "LJEquipListViewController")
        addController("报警信息", "icon_alert", "LJWarnViewController")
        addController("账户设置", "icon_account", "LJSetViewController")
    }
    fileprivate func addController(_ title: String, _ imageName: String, _ storeName: String) {
        guard let vc = UIStoryboard(name: storeName, bundle: nil).instantiateInitialViewController() else {
            return
        }
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_s")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: LJColor.themeColor], for: .selected)
        //        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: 0)], for: .normal)
        let nav = BaseNavigationController(rootViewController: vc)
        lj_setDefaulteInfo(statusStyle: .lightContent, ctr: vc, titleColor: UIColor.white, textColor: UIColor.white, bgColor: LJColor.themeColor)
        addChildViewController(nav)
    }
}
