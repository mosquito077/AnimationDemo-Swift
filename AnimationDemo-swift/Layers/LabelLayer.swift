//
//  LabelLayer.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/3.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class LabelLayer: CATextLayer {
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
         super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillProperties(parentBounds: CGRect, text: String) {
        string = text
        frame = CGRect(x: 0 ,
                       y: (parentBounds.size.height-self.fontSize)/2 ,
                       width: parentBounds.size.width,
                       height: self.fontSize+5)
        fontSize = (UIFont.systemFont(ofSize: 15).pointSize)
        font = CTFontCreateWithName("bold" as CFString, fontSize, nil)
        foregroundColor = UIColor.white.cgColor
        isWrapped = true
        alignmentMode = kCAAlignmentCenter
        contentsScale = UIScreen.main.scale
        opacity = 1.0
    }
    
    func fadeIn() {
        let animationFadeIn = CABasicAnimation(keyPath: "opacity")
        animationFadeIn.fromValue = 1.0
        animationFadeIn.toValue = 0.0
        animationFadeIn.duration = kAnimationDuration
        animationFadeIn.fillMode = kCAFillModeForwards
        animationFadeIn.isRemovedOnCompletion = false
        add(animationFadeIn, forKey: nil)
    }
    
    func fadeOut() {
        let animationFadeOut = CABasicAnimation(keyPath: "opacity")
        animationFadeOut.fromValue = 0.0
        animationFadeOut.toValue = 1.0
        animationFadeOut.duration = kAnimationDuration
        animationFadeOut.fillMode = kCAFillModeForwards
        animationFadeOut.isRemovedOnCompletion = false
        add(animationFadeOut, forKey: nil)
    }

}
