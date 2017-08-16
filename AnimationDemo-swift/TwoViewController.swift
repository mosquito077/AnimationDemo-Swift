//
//  TwoViewController.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/3.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import SnapKit

class TwoViewController: UIViewController, UIViewControllerTransitioningDelegate, CAAnimationDelegate, CircleSpreadTransitionDelegate {
    
    private var backImage: UIImageView!
    private var numButton: UIButton!
    private var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        transitioningDelegate = self
        
        initViews()
    }
    
    func initViews() {
        
        let picImage = UIImage.init(named: "pic.jpg")
        backImage = UIImageView.init(image: picImage)
        backImage.frame = CGRect.zero
        view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(view)
        }
        
        numButton = UIButton.init(frame: CGRect.zero)
        numButton.setTitle("^_^", for: .normal)
        numButton.backgroundColor = UIColor.orange
        numButton.layer.opacity = 0.0
        numButton.layer.cornerRadius = CGFloat(kNumButtonWidthAndHeight/2)
        view.addSubview(numButton)
        numButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view).offset(-30.0)
            make.top.equalTo(view).offset(80.0)
            make.width.height.equalTo(kNumButtonWidthAndHeight)
        }
        
        addButton = UIButton.init(frame: CGRect.zero)
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = UIColor.red
        addButton.layer.opacity = 0.0
        addButton.layer.cornerRadius = CGFloat(kAddButtonWidthAndHeight/2)
        addButton.addTarget(self, action: #selector(animationStart(button:)), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view).offset(-30.0)
            make.bottom.equalTo(view).offset(-50.0)
            make.width.height.equalTo(kAddButtonWidthAndHeight)
        }
    }
    
    @objc private func animationStart(button:UIButton) {
        let centerAnimation = CABasicAnimation(keyPath: "position")
        centerAnimation.fromValue = CGPoint(x: addButton.center.x, y: addButton.center.y)
        centerAnimation.toValue = CGPoint(x: view.center.x, y: view.center.y)
        centerAnimation.duration = kAnimationDuration
        centerAnimation.fillMode = kCAFillModeForwards
        centerAnimation.isRemovedOnCompletion = false
        centerAnimation.delegate = self
        centerAnimation.setValue("value", forKey: "addButtonPosition")
        addButton.layer.add(centerAnimation, forKey: "addButtonPosition")
    }
    
    func _animationWithButtons() {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 1.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 1.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]
        animationGroup.beginTime = 0.6
        animationGroup.duration = kAnimationDuration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.delegate = self
        animationGroup.setValue("key", forKey: "scaleAnimation")
        
        addButton.layer.add(animationGroup, forKey: "animationGroup")

    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if (anim.value(forKey: "addButtonPosition") != nil) {
                dismiss(animated: true, completion: nil)
            } else if (anim.value(forKey: "scaleAnimation") != nil) {
                
                addButton.alpha = 1.0
                                
                let numOpacityAnimation = CABasicAnimation(keyPath: "opacity")
                numOpacityAnimation.toValue = 1.0
                
                let numScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                numScaleAnimation.fromValue = 0.0
                numScaleAnimation.toValue = 1.0
                
                let numAnimationGroup = CAAnimationGroup()
                numAnimationGroup.animations = [numOpacityAnimation, numScaleAnimation]
                numAnimationGroup.duration = kAnimationDuration
                numAnimationGroup.fillMode = kCAFillModeForwards
                numAnimationGroup.isRemovedOnCompletion = false
                
                numButton.layer.add(numAnimationGroup, forKey: "numAnimationGroup")
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
        
        let presentAnimator = PresentTransitionAnimator.init()
        presentAnimator.initWithTransitionType(transtionType: .present)
        presentAnimator.transitionDelegate = self
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let dismissAnimator = PresentTransitionAnimator.init()
        dismissAnimator.initWithTransitionType(transtionType: .dismiss)
        return dismissAnimator
    }
    
    var smallFrame: CGRect {
        return CGRect(x: (kScreenWidth-CGFloat(kAddButtonWidthAndHeight))/2, y: (kScreenHeight-CGFloat(kAddButtonWidthAndHeight))/2, width: CGFloat(kAddButtonWidthAndHeight), height: CGFloat(kAddButtonWidthAndHeight))
    }
    
    var expandFrame: CGRect {
        let radius = kScreenHeight+CGFloat(kCircleRadiusExpand)
        return CGRect(x: view.center.x-radius/2, y: view.center.y-radius/2, width: radius, height: radius)
    }
    
    func presentAnimationDidStop() {
        _animationWithButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
