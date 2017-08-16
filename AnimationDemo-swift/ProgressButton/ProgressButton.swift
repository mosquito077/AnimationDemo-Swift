//
//  ProgressButton.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/3.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

protocol ProgressAnimationDelegate: class {
    func animationDidStop()
}

class ProgressButton: UIButton, LoadingCircleLayerProtocol, RectangleProtocol, CAAnimationDelegate {

    private var rectangleLayer = RectangleLayer()
    private var labelLayer = LabelLayer()
    private var loadingLayer = LoadingCircleLayer()
    weak var progressDelegate: ProgressAnimationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        backgroundColor = UIColor.clear
        
        rectangleLayer.delegateAnimation = self
        layer.addSublayer(rectangleLayer)
        
        layer.addSublayer(labelLayer)
        
        loadingLayer.loadingDelegate = self
        layer.addSublayer(loadingLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rectangleLayer.fillProperties(parentBounds: bounds, color: UIColor.red)
        labelLayer.fillProperties(parentBounds: bounds, text: "Sign In")
        loadingLayer.fillProperties(parentBounds: bounds, radius: CGFloat(circleRadius))
    }
    
    var circleRadius: CFloat {
        return ceil(CFloat(min(self.frame.height, self.frame.width)/2.0))
    }
    
    func animate() {
        hideLabel()
        rectangleLayer.animate()
    }
    
    func hideLabel() {
        labelLayer.fadeIn()
    }
    
    func rectangleAnimationDidStop() {
        loadingLayer.loadingAnimate()
    }
    
    func loadingAnimationDidStop() {
        loadingLayer.fadeIn()
        rectangleLayer.animateInitialState()
        labelLayer.fadeOut()
        
        progressDelegate?.animationDidStop()
    }

}
