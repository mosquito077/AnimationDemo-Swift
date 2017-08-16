//
//  ViewController.swift
//  AnimationDemo-swift
//
//  Created by mosquito on 2017/8/16.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ProgressAnimationDelegate, UITextFieldDelegate {
    
    var signButton: ProgressButton!
    var accountTF: UITextField!
    var passwordTF: UITextField!
    
    var buttonWidth: CGFloat!
    var buttonHeight: CGFloat!
    var buttonX: CGFloat!
    var buttonY: CGFloat!
    var radius: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backGroundLayer()
        setUpViews()
        
        signButton.progressDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonWidth = CGFloat(kSignButtonWidthMargin)
        buttonHeight = CGFloat(kSignButtonHeightMargin)
        buttonX = CGFloat((kScreenWidth-CGFloat(kSignButtonWidthMargin))/2)
        buttonY = CGFloat(kScreenHeight-CGFloat(kSignButtonBottomMargin)-CGFloat(kSignButtonHeightMargin))
        radius = sqrt((buttonX+buttonWidth/2)*(buttonX+buttonWidth/2)+(buttonY+buttonHeight/2+30)*(buttonY+buttonHeight/2+30))
    }
    
    func backGroundLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds;
        //设置渐变的主颜色
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x:0.5, y:0)
        gradientLayer.endPoint = CGPoint(x:0.5, y:1)
        gradientLayer.locations = [0.65, 1];
        view.layer.addSublayer(gradientLayer)

    }
    
    func setUpViews() {
        
        let titleLabel = UITextField.init(frame: CGRect.zero)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "CLOVER"
        titleLabel.font = UIFont.systemFont(ofSize: 40.0)
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.view).offset(150.0)
            make.width.equalTo(200.0)
            make.height.equalTo(50.0)
        }
        
        accountTF = UITextField.init(frame: CGRect.zero)
        accountTF.placeholder = "Username"
        view.addSubview(accountTF)
        accountTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.view).offset(350.0)
            make.width.equalTo(270.0)
            make.height.equalTo(30.0)
        }
        
        passwordTF = UITextField.init(frame: CGRect.zero)
        passwordTF.placeholder = "Password"
        view.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.accountTF).offset(60.0)
            make.width.equalTo(270.0)
            make.height.equalTo(30.0)
        }
        
        signButton = ProgressButton.init(frame: CGRect.zero)
        signButton.tintColor = UIColor.white
        signButton.layer.cornerRadius = 22.5
        signButton.addTarget(self, action: #selector(signButtonTapped), for: UIControlEvents.touchUpInside)
        view.addSubview(signButton)
        signButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view).offset(-kSignButtonBottomMargin)
            make.width.equalTo(kSignButtonWidthMargin)
            make.height.equalTo(kSignButtonHeightMargin)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        accountTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    func signButtonTapped(_ sender: Any) {
        signButton.animate()
    }
    
    func animationDidStop() {
        let secondView = TwoViewController()
        self.present(secondView, animated: true, completion: nil)
    }
    
    public var startPathFrame:CGRect {
        return CGRect(x: buttonX+(buttonWidth-buttonHeight)/2,
                      y: buttonY,
                      width: buttonHeight,
                      height: buttonHeight)
    }
    
    public var endPathFrame:CGRect {
        return CGRect(x: buttonX-(radius-buttonHeight/2),
                      y: -(radius-buttonY),
                      width: radius*2,
                      height: radius*2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
