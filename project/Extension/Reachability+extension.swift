//
//  Reachability+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import MBProgressHUD

import Reachability

var lj_reachability: Reachability?
extension Reachability {
    func lj_showStatus() {
        guard let reachability = lj_reachability else {
            return
        }
        switch reachability.connection {
        case .wifi:
            break;
        case .cellular:
            MBProgressHUD.lj_showText(text: "当前是运营商网络")
        case .none:
            MBProgressHUD.lj_showText(text: "无网络连接,请检查网络设置")
        }
    }
}
