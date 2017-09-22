//
//  BaseTable.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

protocol BaseTable {
    func setBaseDefaults()
}

extension BaseTable {
    func setBaseDefaults() {
        guard let tb = self as? UITableView else {
            return
        }
        //        tb.backgroundColor = LJColor.tableColor
        tb.tableFooterView = UIView()
    }
}
