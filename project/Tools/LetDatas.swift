//
//  LetDatas.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

let lj_screen = UIScreen.main.bounds
let lj_screenWidth = lj_screen.width
let lj_screenHeight = lj_screen.height

let lj_iphone4 = lj_screenHeight <= 480
let lj_iphone5 = lj_screenHeight <= 568
let lj_iphone6 = lj_screenHeight <= 730 && lj_screenHeight > 568
let lj_iphone6_plus = lj_screenHeight <= 736 && lj_screenHeight > 667
let lj_iphoneX = lj_screenHeight <= 813 && lj_screenHeight > 736
let lj_ipad = UIDevice.current.userInterfaceIdiom == .pad
let lj_window = UIApplication.shared.keyWindow ?? UIWindow()

var lj_reachable: Reachability?
