//
//  CyclePictureCell.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import Kingfisher

class CyclePictureCell: UICollectionViewCell {
    
    var imageSource: ImageSource = ImageSource.Local(name: ""){
        didSet {
            switch imageSource {
            case let .Local(name):
                self.imageView.image = UIImage(named: name)
            case let .Network(urlStr):
                let resource = ImageResource(downloadURL: URL(string: urlStr)!, cacheKey: nil)
                self.imageView.kf.setImage(with: resource, placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    var placeholderImage: UIImage?
    
    var imageDetail: String? {
        didSet {
            detailLable.isHidden = false
            detailLable.text = imageDetail
            
        }
    }
    
    var detailLableTextFont: UIFont = UIFont(name: "Helvetica-Bold", size: 18)! {
        didSet {
            detailLable.font = detailLableTextFont
        }
    }
    
    var detailLableTextColor: UIColor = UIColor.white {
        didSet {
            detailLable.textColor = detailLableTextColor
        }
    }
    
    var detailLableBackgroundColor: UIColor = UIColor.clear {
        didSet {
            detailLable.backgroundColor = detailLableBackgroundColor
        }
    }
    
    var detailLableHeight: CGFloat = 60 {
        didSet {
            detailLable.frame.size.height = detailLableHeight
        }
    }
    
    var detailLableAlpha: CGFloat = 1 {
        didSet {
            detailLable.alpha = detailLableAlpha
        }
    }
    
    var pictureContentMode: UIViewContentMode = .scaleAspectFill {
        didSet {
            imageView.contentMode = pictureContentMode
        }
    }
    
    private var imageView: UIImageView!
    private var detailLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupImageView()
        self.setupDetailLable()
        //        self.backgroundColor = UIColor.grayColor()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = pictureContentMode
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    private func setupDetailLable() {
        detailLable = UILabel()
        detailLable.textColor = detailLableTextColor
        detailLable.shadowColor = UIColor.gray
        detailLable.numberOfLines = 0
        detailLable.backgroundColor = detailLableBackgroundColor
        
        detailLable.isHidden = true //默认是没有描述的，所以隐藏它
        
        self.addSubview(detailLable!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
        
        if let _ = self.imageDetail {
            let lableX: CGFloat = 0
            let lableH: CGFloat = detailLableHeight
            let lableW: CGFloat = self.frame.width - lableX
            let lableY: CGFloat = self.frame.height - lableH
            detailLable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            detailLable.font = detailLableTextFont
        }
    }
}
