//
//  LJCalendarVC.swift
//  project
//
//  Created by 刘蒋 on 2017/9/26.
//  Copyright © 2017年 刘蒋. All rights reserved.
//


import UIKit
import FSCalendar

class LJCalendarVC: UIViewController, BaseVC {
    
    var block: ((Date) -> ())?
    
    var currentDate = Date()
    fileprivate lazy var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseDefaults()
        
        //        let btn = UIButton()
        //        btn.setImage(#imageLiteral(resourceName: "back-icon"), for: .normal)
        //        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -14, bottom: 0, right: 14)
        //        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        //        btn.addTarget(self, action: #selector(dismissCurrentView), for: .touchUpInside)
        //        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .done, target: self, action: #selector(dismissCurrentView))
        
        calendar.scrollDirection = .vertical
        calendar.frame = view.frame
        view.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.currentPage = currentDate
        calendar.select(currentDate, scrollToDate: true)
        title = "请选择日期"
    }
    //    @objc fileprivate func dismissCurrentView() {
    //        dismiss(animated: true, completion: nil)
    //    }
    override func viewWillAppear(_ animated: Bool) {
        lj_setDefaulteInfo(statusStyle: .lightContent, ctr: self, titleColor: UIColor.white, textColor: UIColor.white, bgColor: LJColor.themeColor)
    }
}
extension LJCalendarVC: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //        dismiss(animated: true) {[weak self] in
        //            self?.block?(date)
        //        }
        block?(date)
        navigationController?.popViewController(animated: true)
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame = CGRect(origin: calendar.frame.origin, size: calendar.frame.size)
    }
    
}

