//
//  PresentTransitionAnimator.swift
//  AnimationDemo_Swift
//
//  Created by mosquito on 2017/7/4.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

enum CircleSpreadTransitionType {
    case present
    case dismiss
}

protocol CircleSpreadTransitionDelegate: class {
    func presentAnimationDidStop()
}

class PresentTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    weak var transitionDelegate: CircleSpreadTransitionDelegate?
    let duration = 0.5
    var type = CircleSpreadTransitionType.present
    
    func transitionWithTransitionType(type: CircleSpreadTransitionType) {
        let transitionAnimator = PresentTransitionAnimator.init()
        transitionAnimator.initWithTransitionType(transtionType: type)
    }
    
    func initWithTransitionType(transtionType: CircleSpreadTransitionType) {
        type = transtionType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            presentAnimation(context: transitionContext)
            break
            
        case .dismiss:
            dismissAnimation(context: transitionContext)
            break
            
        }
    }
    
    func presentAnimation(context: UIViewControllerContextTransitioning) {
        let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let temp = fromViewController as! ViewController
        toViewController.view.backgroundColor = UIColor.red
        let containerView = context.containerView
        containerView.addSubview(toViewController.view)
        
        let startCycle = UIBezierPath.init(roundedRect: temp.startPathFrame, cornerRadius: temp.startPathFrame.size.height/2)
        let endCycle = UIBezierPath.init(roundedRect: temp.endPathFrame, cornerRadius: temp.endPathFrame.size.height/2)
        
        let maskLayer = CAShapeLayer.init(layer: (Any).self)
        maskLayer.path = endCycle.cgPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.delegate = self
        maskLayerAnimation.fromValue = startCycle.cgPath
        maskLayerAnimation.toValue = endCycle.cgPath
        maskLayerAnimation.duration = transitionDuration(using: context)
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayerAnimation.setValue(context, forKey: "transitionContext")
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func dismissAnimation(context: UIViewControllerContextTransitioning) {
        let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let temp = fromViewController as! TwoViewController
        toViewController.view.backgroundColor = UIColor.red
        let containerView = context.containerView
        containerView.addSubview(toViewController.view)
        
        let startCycle = UIBezierPath.init(roundedRect: temp.smallFrame, cornerRadius: temp.smallFrame.size.height/2)
        let endCycle = UIBezierPath.init(roundedRect: temp.expandFrame, cornerRadius: temp.expandFrame.size.height/2)
        
        let maskLayer = CAShapeLayer.init(layer: (Any).self)
        maskLayer.path = endCycle.cgPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.delegate = self
        maskLayerAnimation.fromValue = startCycle.cgPath
        maskLayerAnimation.toValue = endCycle.cgPath
        maskLayerAnimation.duration = transitionDuration(using: context)
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayerAnimation.setValue(context, forKey: "transitionContext")
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch type {
        case .present:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(true)
            transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.backgroundColor = UIColor.white
            
            transitionDelegate?.presentAnimationDidStop()
            break
            
        case .dismiss:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.backgroundColor = UIColor.white
            break
            
        }
    }

}
