//
//  LJNormalPickView.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

class LJPickView: UIView {
    
    var selectIndexBlock : ((Int, Int, Int) -> ())?
    
    fileprivate var cancelButton = UIButton()
    fileprivate var okButton = UIButton()
    fileprivate var lineView = UIView()
    fileprivate var pickView = UIPickerView()
    
    var dataSources: [[String]] = [] {
        didSet {
            self.pickView.reloadAllComponents()
        }
    }
    
    var selectRow: Int? {
        didSet {
            pickView.selectRow(selectRow ?? 0, inComponent: 0, animated: false)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        cancelButton.titleLabel?.font = LJFont.font_14
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(LJColor.textColor, for: .normal)
        cancelButton.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        addSubview(cancelButton)
        okButton.titleLabel?.font = LJFont.font_14
        okButton.setTitle("确定", for: .normal)
        okButton.setTitleColor(LJColor.themeColor, for: .normal)
        okButton.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        addSubview(okButton)
        lineView.backgroundColor = LJColor.bgColor
        addSubview(lineView)
        pickView.delegate = self
        pickView.dataSource = self
        addSubview(pickView)
    }
    
    @objc fileprivate func btnClick(_ sender: UIButton) {
        switch sender {
        case cancelButton:
            selectIndexBlock?(-1, -1, -1)
        default:
            switch dataSources.count {
            case 1:
                selectIndexBlock?(pickView.selectedRow(inComponent: 0), -1, -1)
            case 2:
                selectIndexBlock?(pickView.selectedRow(inComponent: 0), pickView.selectedRow(inComponent: 1), -1)
            default:
                selectIndexBlock?(pickView.selectedRow(inComponent: 0), pickView.selectedRow(inComponent: 1), pickView.selectedRow(inComponent: 2))
            }
            
            //            selectIndexBlock?(-1, -1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LJPickView {
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.top.equalToSuperview()
            make.width.equalTo(60)
        }
        okButton.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.height.width.equalTo(cancelButton)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom)
            make.height.equalTo(1)
        }
        pickView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
        }
    }
}
extension LJPickView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard dataSources.count <= 3 else {
            return 3
        }
        return dataSources.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSources[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataSources[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        if lj_iphone5 {
            label.font = LJFont.font_13
        }else if lj_iphone6 {
            label.font = LJFont.font_15
        }else {
            label.font = LJFont.font_16
        }
        
        label.backgroundColor = LJColor.clearColor
        label.textAlignment = .center
        label.text = self.dataSources[component][row]
        return label
    }
}
