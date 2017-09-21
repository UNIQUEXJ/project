//
//  LJNewFeatureController.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import SnapKit

class LJNewFeatureController: UIViewController, UIScrollViewDelegate {
    
    var startMainView:(() -> Void)?
    
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var startBtn: UIButton!
    private var tiaoBtn = UIButton()
    let arr = ["newFeature_1.jpg","newFeature_2.jpg","newFeature_3.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        initViews()
    }
    
    private func initViews() {
        
        if scrollView == nil {
            scrollView = UIScrollView(frame: lj_screen)
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.bounces = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.contentSize = CGSize(width: CGFloat(arr.count) * lj_screenWidth, height: lj_screenHeight)
            scrollView.showsVerticalScrollIndicator = false
            view.addSubview(scrollView)
            for i in 0 ..< arr.count {
                
                let imgView = UIImageView(frame: CGRect(x: CGFloat(i) * lj_screenWidth, y: 0, width: lj_screenWidth, height: lj_screenHeight))
                imgView.image = UIImage(named: arr[i])
                self.scrollView.addSubview(imgView)
            }
        }
        if pageControl == nil {
            
            pageControl = UIPageControl(frame: CGRect(x: (lj_screenWidth - 150) / 2, y: lj_screenHeight - 80, width: 150, height: 30))
            pageControl.numberOfPages = arr.count
            view.addSubview(pageControl)
            pageControl.pageIndicatorTintColor = UIColor.white
            pageControl.currentPageIndicatorTintColor = LJColor.themeColor
        }
        
        tiaoBtn.backgroundColor = UIColor.white
        tiaoBtn.layer.cornerRadius = 4
        tiaoBtn.layer.masksToBounds = true
        tiaoBtn.alpha = 0.3
        tiaoBtn.setTitle("跳过", for: .normal)
        tiaoBtn.setTitleColor(UIColor.black, for: .normal)
        tiaoBtn.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        tiaoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(tiaoBtn)
        tiaoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.height.equalTo(30)
            make.width.equalTo(57)
        }
        
        if startBtn == nil {
            startBtn = UIButton()
            //            startBtn.layer.cornerRadius = 4
            //            startBtn.layer.masksToBounds = true
            //            startBtn.setTitleColor(UIColor.white, for: .normal)
            startBtn.alpha = 0
            startBtn.backgroundColor = UIColor.clear
            startBtn.setBackgroundImage(#imageLiteral(resourceName: "newFeature_button"), for: .normal)
            //            startBtn.setTitle("开始体验", for: .normal)
            startBtn.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
            //            startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            view.addSubview(startBtn)
            startBtn.snp.makeConstraints { (make) in
                make.bottom.equalTo(-107)
                make.width.equalTo(140)
                make.height.equalTo(49)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    @objc private func clickButton(_ sender: UIButton) {
        
        startMainView!()
        //        UIPasteboard.generalPasteboard().string = "你好"
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / lj_screenWidth
        pageControl.currentPage = Int(index)
        
        if pageControl.currentPage == arr.count - 1 {
            tiaoBtn.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.startBtn.alpha = 1
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        startBtn.alpha = 0
        tiaoBtn.alpha = 0.3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
