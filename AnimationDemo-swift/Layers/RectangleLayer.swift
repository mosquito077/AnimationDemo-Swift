//
//  RectangleLayer.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/3.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

protocol RectangleProtocol: class {
    func rectangleAnimationDidStop()
}

class RectangleLayer: CAShapeLayer, CAAnimationDelegate {
    
    var frameRect: CGRect!
    var frameSquare: CGRect!
    weak var delegateAnimation: RectangleProtocol?
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillProperties(parentBounds: CGRect, color: UIColor) {
        frameRect = CGRect(x: 0 , y: 0, width: parentBounds.size.width, height: parentBounds.size.height)
        frameSquare = CGRect(x: frameRect.size.width/2-frameRect.size.height/2 , y: 0, width: frameRect.size.height, height: frameRect.size.height)
        path = roundedRectangle.cgPath
        fillColor = color.cgColor
    }
    
    var roundedRectangle: UIBezierPath {
        return UIBezierPath(roundedRect: frameRect, cornerRadius: frameRect.size.height/2)
    }
    
    var roundedSquare: UIBezierPath {
        return UIBezierPath(roundedRect: frameSquare, cornerRadius: frameSquare.size.height/2)
    }
    
    func animate() {
        let animationSquare = CABasicAnimation(keyPath: "path")
        animationSquare.fromValue = roundedRectangle.cgPath
        animationSquare.toValue = roundedSquare.cgPath
        animationSquare.delegate = self
        animationSquare.beginTime = 0.0
        animationSquare.duration = 0.4
        animationSquare.fillMode = kCAFillModeForwards
        animationSquare.isRemovedOnCompletion = false
        add(animationSquare, forKey: nil)
    }
    
    func animateInitialState() {
        let animationRectangle = CABasicAnimation(keyPath: "path")
        animationRectangle.fromValue = roundedSquare.cgPath
        animationRectangle.toValue = roundedRectangle.cgPath
        animationRectangle.duration = 0.4
        animationRectangle.fillMode = kCAFillModeForwards
        animationRectangle.isRemovedOnCompletion = false
        add(animationRectangle, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegateAnimation?.rectangleAnimationDidStop()
    }

}
