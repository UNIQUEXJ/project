//
//  LJADLabel.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

class LJADLabel: UIView {
    
    fileprivate var gcdTimer: DispatchSourceTimer?
    
    fileprivate lazy var currentLabel = UILabel()
    fileprivate lazy var bottomLabel = UILabel()
    var textColor : UIColor = UIColor.orange {
        didSet {
            currentLabel.textColor = textColor
            bottomLabel.textColor = textColor
        }
    }
    var font: UIFont = LJFont.font_12 {
        didSet {
            currentLabel.font = font
            bottomLabel.font = font
        }
    }
    var textAlignment: NSTextAlignment = NSTextAlignment.left {
        didSet {
            currentLabel.textAlignment = textAlignment
            bottomLabel.textAlignment = textAlignment
        }
    }
    var lineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            currentLabel.lineBreakMode = lineBreakMode
            bottomLabel.lineBreakMode = lineBreakMode
        }
    }
    var stringArrays: [String] = [] {
        didSet {
            setupTimer()
        }
    }
    var timeInterval: Double = 4.0 {
        didSet {
            setupTimer()
        }
    }
    fileprivate var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        //        currentLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(currentLabel)
        //        bottomLabel.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height)
        addSubview(bottomLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currentLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        bottomLabel.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let _ = newSuperview else {
            if gcdTimer != nil {
                gcdTimer?.cancel()
                gcdTimer = nil
            }
            return
        }
    }
    
    fileprivate func setupTimer() {
        guard stringArrays.count > 0 else {
            return
        }
        index = 0
        currentLabel.text = stringArrays[index]
        gcdTimer?.cancel()
        gcdTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        gcdTimer?.schedule(wallDeadline: DispatchWallTime.now() + timeInterval * 0.5, repeating: timeInterval)
        
        gcdTimer?.setEventHandler(handler: {[weak self] in
            self?.changeFrame()
        })
        if #available(iOS 10.0, *) {
            gcdTimer?.activate()
        } else {
            // Fallback on earlier versions
        }
    }
}
extension LJADLabel {
    @objc fileprivate func changeFrame() {
        if stringArrays.count > index {
            currentLabel.text = stringArrays[index]
            if stringArrays.count > index + 1 {
                index += 1
            }else {
                index = 0
            }
            bottomLabel.text = stringArrays[index]
        }
        let width = frame.width
        let height = frame.height
        UIView.animate(withDuration: timeInterval * 0.5, animations: { [weak self] in
            self?.currentLabel.frame = CGRect(x: 0, y: -height, width: width, height: height)
            self?.bottomLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }) { [weak self] (isComplete) in
            self?.currentLabel.text = self?.stringArrays[(self?.index)!]
            self?.bottomLabel.frame = CGRect(x: 0, y: height, width: width, height: height)
            self?.currentLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
}
