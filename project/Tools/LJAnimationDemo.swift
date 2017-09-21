//
//  LJAnimationDemo.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

// MARK: http://www.cocoachina.com/swift/20150911/13215.html

/// 旋转动画
///
/// - Parameter view: <#view description#>
func lj_rotationAnimation(animationView view: UIView) {
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.repeatCount = MAXFLOAT
    animation.duration = 4
    animation.toValue = 2 * Double.pi
    // 动画结束 是否 移除图层
    animation.isRemovedOnCompletion = false
    view.layer.add(animation, forKey: nil)
}


class LJLabelView: UIView {
    
    // @IBInspectable 创建xib可设置属性
    @IBInspectable var isRight: Bool = false
    @IBInspectable var overshootAmount: CGFloat = 10.0
    @IBInspectable var textColor: UIColor = UIColor(hexColor: "508CEE")
    @IBInspectable var textFont: CGFloat = 10
    @IBInspectable var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var alignment: NSTextAlignment = .center
    
    fileprivate let topPoint = UIView()
    fileprivate let rightPoint = UIView()
    fileprivate let bottomPoint = UIView()
    fileprivate let leftPoint = UIView()
    fileprivate let currentShape = CAShapeLayer()
    
    
    /// 定时器
    fileprivate lazy var displaylink: CADisplayLink = {
        let display = CADisplayLink(target: self, selector: #selector(updateLoop))
        display.add(to: .current, forMode: .commonModes)
        return display
    }()
    override var backgroundColor: UIColor? {
        willSet {
            if let newValue = newValue {
                currentShape.fillColor = newValue.cgColor
                super.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startUpdateLoop()
        animatePoints()
    }
    func showAnimation() {
        startUpdateLoop()
        animatePoints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfige()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConfige()
    }
    override func draw(_ rect: CGRect) {
        guard let text = self.text else {
            return
        }
        
        let textWidth = text.lj_stringWidth(UIFont.systemFont(ofSize: textFont))
        let textHeight = text.lj_stringHeight(UIFont.systemFont(ofSize: textFont))
        let textY = rect.height * 0.5 - textHeight * 0.5
        var textX: CGFloat = 0
        if isRight {
            textX = 0
        }else {
            textX = rect.width - textWidth
        }
        //        if textFont <= 10 {
        //            textX = rect.width * 0.5 - textWidth
        //        }else {
        //            textX = rect.width * 0.5 - textWidth * 0.5
        //        }
        let textRect = CGRect(x: textX, y: textY, width: textWidth, height: textHeight)
        addText(text, textRect, color: textColor, font: UIFont.systemFont(ofSize: textFont))
    }
    // MARK: 添加字
    fileprivate func addText(_ name : String, _ textRect: CGRect, color: UIColor, font: UIFont) {
        let tempName = NSString(string: name)
        let attrs = [NSAttributedStringKey.font : font, NSAttributedStringKey.foregroundColor : color]
        tempName.draw(in: textRect, withAttributes: attrs)
    }
    
    fileprivate func animatePoints() {
        self.textColor = UIColor(hexColor: "508CEE")
        self.setNeedsDisplay()
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.5, options: .curveLinear, animations: {[weak self] in
            self?.topPoint.center.y -= self?.overshootAmount ?? 10
            self?.rightPoint.center.x += self?.overshootAmount ?? 10
            self?.bottomPoint.center.y += self?.overshootAmount ?? 10
            self?.leftPoint.center.x -= self?.overshootAmount ?? 10
            
            if lj_iphone5 {
                self?.textFont = 20
            }else {
                self?.textFont = 30
            }
            self?.setNeedsDisplay()
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 5.5, options: .curveLinear, animations: {[weak self] in
                self?.positionPoint()
                self?.textFont = 10
                self?.setNeedsDisplay()
                }, completion: {[weak self] (_) in
                    self?.stopUpdateLoop()
            })
        }
    }
    
    fileprivate func setConfige() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        currentShape.fillColor = backgroundColor?.cgColor
        currentShape.path = UIBezierPath(rect: bounds).cgPath
        layer.addSublayer(currentShape)
        for item in [topPoint, rightPoint, bottomPoint, leftPoint] {
            addSubview(item)
            item.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            //            item.backgroundColor = UIColor.orange
        }
        positionPoint()
    }
    fileprivate func positionPoint() {
        topPoint.center = CGPoint(x: bounds.midX, y: 0)
        rightPoint.center = CGPoint(x: bounds.maxX, y: bounds.midY)
        bottomPoint.center = CGPoint(x: bounds.midX, y: bounds.maxY)
        leftPoint.center = CGPoint(x: 0, y: bounds.midY)
    }
    fileprivate func bezierPathForPoints() -> CGPath {
        let path = UIBezierPath()
        let top = topPoint.layer.presentation()?.position ?? CGPoint(x: 0, y: 0)
        let right = rightPoint.layer.presentation()?.position ?? CGPoint(x: 0, y: 0)
        let bottom = bottomPoint.layer.presentation()?.position ?? CGPoint(x: 0, y: 0)
        let left = leftPoint.layer.presentation()?.position ?? CGPoint(x: 0, y: 0)
        let width = frame.width
        let height = frame.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: 0), controlPoint: top)
        path.addQuadCurve(to: CGPoint(x: width, y: height), controlPoint: right)
        path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint: bottom)
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: left)
        return path.cgPath
    }
    @objc
    fileprivate func updateLoop() {
        currentShape.path = bezierPathForPoints()
    }
    fileprivate func startUpdateLoop() {
        displaylink.isPaused = false
    }
    fileprivate func stopUpdateLoop() {
        displaylink.isPaused = true
    }
}

