//
//  ViewController.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import MBProgressHUD
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, BaseVC {
    fileprivate lazy var userName = UITextField()
    fileprivate lazy var password = UITextField()
    fileprivate lazy var loginButton = UIButton()
    
    fileprivate let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseDefaults()
        setUI()
        userName.text = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        let userNameObserable = userName.rx.text.share(replay: 1).map {
            $0?.lj_isUsername
        }
        let pwdObserable = password.rx.text.share(replay: 1).map {
            $0?.lj_isPasswrod
        }
        userNameObserable.bind(to: userName.ex_validState).disposed(by: disposeBag)
        pwdObserable.bind(to: password.ex_validState).disposed(by: disposeBag)
        Observable.combineLatest(userNameObserable, pwdObserable, resultSelector: { (usernameBool, passwordBool) in
            usernameBool! && passwordBool!
        }).bind(to: loginButton.ex_validState).disposed(by: disposeBag)
    }
    // MARK: 忘记密码点击
    @objc fileprivate func forgetButtonClick() {
        keybordEnd()
        
        let alertCtr = UIAlertController(title: "重置密码", message: "密码将发送到您手机上,请注意查收短信", preferredStyle: .alert)
        alertCtr.addTextField { [weak self] (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "手机号"
            if self?.userName.text?.lj_isPhoneNum ?? false {
                textField.text = self?.userName.text
            }
        }
        let okAction = UIAlertAction(title: "确定", style: .destructive) { [weak self] (okAction) in
            print(self?.view.frame as Any)
            
            //            let phone = alertCtr.textFields?.first
            MBProgressHUD.lj_showText(text: "暂时无法找回密码,请联系管理员")
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertCtr.addAction(okAction)
        alertCtr.addAction(cancelAction)
        present(alertCtr, animated: true, completion: nil)
    }
    // MARK: 登录点击
    @objc fileprivate func loginButtonClick() {
        keybordEnd()
        if !(userName.text?.lj_isUsername ?? false) {
            MBProgressHUD.lj_showText(text: "用户名不正确")
            return
        }
        if !(password.text?.lj_isPasswrod ?? false) {
            MBProgressHUD.lj_showText(text: "密码不正确")
            return
        }
        for item in view.lj_subButtons {
            item.isEnabled = false
        }
        LJNetTools.share.login(["UserName" : userName.text!, "Pwd" : password.text!]) {[weak self] (isSuccess) in
            for item in (self?.view.lj_subButtons)! {
                item.isEnabled = true
            }
            if isSuccess {
                UserDefaults.standard.lj_setDefaults("userName", value: (self?.userName.text)!)
                print("登录成功")
            }
        }
    }
    // MARK: 注册
    @objc fileprivate func registerButtonClick() {
        keybordEnd()
        MBProgressHUD.lj_showText(text: "暂时无法注册,请联系管理员")
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            print(self.view.safeAreaInsets)
        } else {
            // Fallback on earlier versions
        }
    }
}
extension ViewController {
    fileprivate func setUI() {
        view.backgroundColor = UIColor.white
        // 添加控件
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "icon_logo")
        view.addSubview(imageView)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.lj_colorChun(222, 1)
        view.addSubview(bottomView)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bottomView.addSubview(bgView)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lj_colorChun(222, 1)
        bgView.addSubview(lineView)
        
        let userNameImg = UIImageView()
        userNameImg.image = #imageLiteral(resourceName: "icon_user")
        userNameImg.contentMode = .center
        bgView.addSubview(userNameImg)
        
        userName.delegate = self
        userName.placeholder = "请输入手机"
        userName.textColor = LJColor.textColor
        userName.keyboardType = .numbersAndPunctuation
        userName.clearButtonMode = .whileEditing
        bgView.addSubview(userName)
        
        let passwordImg = UIImageView()
        passwordImg.image = #imageLiteral(resourceName: "icon_key")
        passwordImg.contentMode = .center
        bgView.addSubview(passwordImg)
        
        password.delegate = self
        password.placeholder = "请输入密码"
        password.textColor = LJColor.textColor
        password.keyboardType = .default
        password.clearButtonMode = .whileEditing
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        bgView.addSubview(password)
        
        let forgetButton = UIButton()
        forgetButton.setTitle("忘记密码?", for: .normal)
        forgetButton.titleLabel?.font = LJFont.font_14
        forgetButton.contentMode = .right
        forgetButton.setTitleColor(LJColor.themeColor, for: .normal)
        forgetButton.addTarget(self, action: #selector(forgetButtonClick), for: .touchUpInside)
        view.addSubview(forgetButton)
        
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.isEnabled = false
        loginButton.setBackgroundImage(UIImage.lj_creatImageWithColor(LJColor.themeColor), for: .normal)
        loginButton.setBackgroundImage(UIImage.lj_creatImageWithColor(LJColor.themeDisableColor), for: .disabled)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = LJFont.font_16
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        view.addSubview(loginButton)
        
        let registerButton = UIButton()
        registerButton.backgroundColor = UIColor.white
        registerButton.setTitleColor(LJColor.themeColor, for: .normal)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = LJFont.font_16
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = LJColor.themeColor.cgColor
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        view.addSubview(registerButton)
        // 布局
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.width.height.equalTo(88)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(44)
            make.height.equalTo(89.5)
            make.left.right.equalToSuperview()
        }
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(0.5)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(0.5)
            make.center.equalToSuperview()
        }
        userNameImg.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(44)
            make.top.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
        }
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(userNameImg.snp.right)
            make.bottom.equalTo(lineView.snp.top)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        passwordImg.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(15)
            make.bottom.equalToSuperview()
            make.width.equalTo(44)
        }
        password.snp.makeConstraints { (make) in
            make.left.equalTo(passwordImg.snp.right)
            make.bottom.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.right.equalToSuperview().inset(10)
        }
        forgetButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(bottomView.snp.bottom)
            make.height.equalTo(44)
            make.width.equalTo("忘记密码?".lj_stringWidth(LJFont.font_14) + 10)
        }
        loginButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(forgetButton.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        registerButton.snp.makeConstraints { [weak self] (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo((self?.loginButton.snp.bottom)!).offset(13)
            make.height.equalTo(40)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        keybordEnd()
//        let url = "http://192.168.31.110:8888"
        let url = "http://127.0.0.1:8888"
        
        Alamofire.request(url + "/api/test", method: .get, parameters: ["id": "getId", "testGet": "testId"], headers: ["get": "test"]).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error as Any)
            case .success(let data):
                print(JSON(data) as Any)
            }
        }
        Alamofire.request(url + "/api/home", method: .post, parameters: ["postId": "testPost"], headers: ["post": "test"]).responseJSON { (response) in
            print(response.result.value as Any)
        }
    }
    // MARK: 键盘退出,修改UI
    fileprivate func keybordEnd() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.frame = CGRect(x: 0, y: 0, width: lj_screenWidth, height: lj_screenHeight)
        })
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if lj_iphone5 {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.view.frame = CGRect(x: 0, y: -100, width: lj_screenWidth, height: lj_screenHeight)
            })
        }else if !lj_ipad {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.view.frame = CGRect(x: 0, y: -70, width: lj_screenWidth, height: lj_screenHeight)
            })
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keybordEnd()
        return true
    }
}

extension UITextField {
    var ex_validState: AnyObserver<Bool?> {
        return Binder(self, binding: { (textfield, valid) in
            textfield.textColor = valid! ? LJColor.textColor : UIColor.red
        }).asObserver()
    }
}

extension UIButton {
    var ex_validState: AnyObserver<Bool> {
        return Binder(self, binding: { (button, valid) in
            button.isEnabled = valid
        }).asObserver()
    }
}
