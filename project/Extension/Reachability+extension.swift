//
//  Reachability+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import MBProgressHUD

extension Reachability {
    var lj_isNotNet: Bool {
        switch currentReachabilityStatus() {
        case NotReachable:
            return true
        default:
            return false
        }
    }
    func lj_showStatus() {
        switch currentReachabilityStatus() {
        case ReachableViaWiFi:
            break;
        case ReachableViaWWAN:
            MBProgressHUD.lj_showText(text: "当前是运营商网络")
        case NotReachable:
            MBProgressHUD.lj_showText(text: "无网络连接,请检查网络设置")
        default:
            break;
        }
    }
}
