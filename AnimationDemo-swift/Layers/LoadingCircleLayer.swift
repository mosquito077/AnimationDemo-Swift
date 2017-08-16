//
//  LoadingCircleLayer.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/3.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

protocol LoadingCircleLayerProtocol: class {
    func loadingAnimationDidStop()
}

class LoadingCircleLayer: CAShapeLayer, CAAnimationDelegate {
    
    private let circleAnimationDuration:CGFloat = 0.6
    var circleRadius: CGFloat!
    weak var loadingDelegate: LoadingCircleLayerProtocol?
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
    }
    
    func fillProperties(parentBounds: CGRect, radius: CGFloat) {
        frame = CGRect(x: parentBounds.size.width/2-parentBounds.size.height/2, y: 0, width: parentBounds.size.height, height: parentBounds.size.height)
        cornerRadius = parentBounds.size.height/2
        backgroundColor = UIColor.clear.cgColor
        circleRadius = radius-5
        fillColor = UIColor.clear.cgColor
        strokeColor = UIColor.white.cgColor
        path = loadingPath.cgPath
        lineWidth = 1.0
        opacity = 0.0
    }
    
    func loadingAnimate() {
        opacity = 1.0
        let circleGap = 0.15
        let strokeEnd = 1.0-circleGap
        
        let strokeEndToStart = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndToStart.fromValue = circleGap
        strokeEndToStart.toValue = strokeEnd
        strokeEndToStart.duration = CFTimeInterval(circleAnimationDuration)
        strokeEndToStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let strokeEndToEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndToEnd.beginTime = CFTimeInterval(circleAnimationDuration)
        strokeEndToEnd.fromValue = strokeEnd
        strokeEndToEnd.toValue = circleGap
        strokeEndToEnd.duration = CFTimeInterval(circleAnimationDuration)
        strokeEndToEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let joggingAnimationGroup = CAAnimationGroup()
        joggingAnimationGroup.animations = [strokeEndToStart, strokeEndToEnd]
        joggingAnimationGroup.duration = CFTimeInterval(circleAnimationDuration*2)
        joggingAnimationGroup.repeatCount = 0
        add(joggingAnimationGroup, forKey: "CircleTypeAnimationJoggingGroup")
        
        let startRotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        startRotationAnimation.toValue = Double.pi * 2.0 * 3.0
        startRotationAnimation.duration = CFTimeInterval(circleAnimationDuration*2)
        startRotationAnimation.repeatCount = 0
        startRotationAnimation.delegate = self as CAAnimationDelegate
        startRotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        add(startRotationAnimation, forKey: "CircleTypeAnimationRotationGroup")
    }
    
    func fadeIn() {
        opacity = 0.0
    }
    
    var loadingPath: UIBezierPath {
        return UIBezierPath(arcCenter : CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0), radius: circleRadius, startAngle: CGFloat(Double.pi*1.75), endAngle: CGFloat(Double.pi*1.25), clockwise: true)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        loadingDelegate?.loadingAnimationDidStop()
    }
    
}
