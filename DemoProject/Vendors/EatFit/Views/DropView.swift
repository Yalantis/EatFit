//
//  DropView.swift
//  Pager
//
//  Created by aleksey on 08.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import Foundation
import UIKit

class DropView : UIView {
    var chartThickness: CGFloat = 0
    var logo: UIImage {
        set {
            logoImageView.image = newValue
            logoImageView.frame = CGRect(x: 0.0, y: 0.0, width: newValue.size.width, height: newValue.size.height)
        }
        get {
            return logoImageView.image!
        }
    }
    let fallEaseIn = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 1.0, 0.4)
    let fallEaseOut = CAMediaTimingFunction(controlPoints: 0.0, 0.4, 0.4, 1.0)
    let logoImageView: UIImageView = UIImageView()

    var color: UIColor {
        set {
            drop.fillColor = newValue.CGColor
            logoImageView.tintColor = newValue
        }
        get {
            return UIColor(CGColor: drop.fillColor!)
        }
    }
    var drop: CAShapeLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(logoImageView)
        logoImageView.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drop.frame = CGRect(x: (bounds.width - chartThickness) / 2.0, y: -(chartThickness / 2.0), width: chartThickness, height: chartThickness)
        drop.path = UIBezierPath(ovalInRect: drop.bounds).CGPath
        
         logoImageView.frame = CGRect(x: (bounds.width - 30.0) / 2.0, y: -chartThickness, width: 30.0, height: 30.0)
    }
    
    func animateDrop (delay delay: NSTimeInterval) {
        self.layer.addSublayer(drop)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            self.performDropAnimation()
        }
    }
    
    func performDropAnimation () {
        let dropFall: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.y")
        dropFall.duration = 0.3
        dropFall.toValue = self.frame.size.height - chartThickness
        dropFall.timingFunction = fallEaseIn
        
        let dropLay: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.y")
        dropLay.duration = 0.05
        dropLay.toValue = dropFall.toValue
        dropLay.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        
        let dropJump: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.y")
        dropJump.duration = dropFall.duration * 1.5
        dropJump.toValue = 0.0
        dropJump.timingFunction = fallEaseOut
        
        let group: CAAnimationGroup = CAAnimationGroup(sequence: [dropFall, dropLay, dropJump])
        drop.addAnimation(group, forKey: "move")
        
        let dropSmash: CABasicAnimation = CABasicAnimation(keyPath:"transform.scale.y")
        dropSmash.beginTime = CACurrentMediaTime() + dropLay.beginTime - 0.1
        dropSmash.duration = dropLay.duration
        dropSmash.repeatCount = 1.0
        dropSmash.fromValue = 1.0
        dropSmash.toValue = 0.6
        dropSmash.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        dropSmash.autoreverses = true
        dropSmash.removedOnCompletion = false
        
        drop.addAnimation(dropSmash, forKey: "smash")
    }
    
    func animateLogo (delay delay: NSTimeInterval) {
        logoImageView.layer.removeAllAnimations()
        logoImageView.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        
        let dropDisappear: CABasicAnimation = CABasicAnimation(keyPath:"transform.scale")
        dropDisappear.beginTime = CACurrentMediaTime() + delay
        dropDisappear.duration = 0.3
        dropDisappear.repeatCount = 1.0
        dropDisappear.fromValue = 1.0
        dropDisappear.toValue = NSValue(CATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0))
        dropDisappear.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        dropDisappear.autoreverses = false
        dropDisappear.removedOnCompletion = false
        dropDisappear.fillMode = kCAFillModeForwards
        
        drop.addAnimation(dropDisappear, forKey: "disappear")
        
        let dropMove: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.y")
        dropMove.beginTime = CACurrentMediaTime() + delay
        dropMove.duration = dropDisappear.duration
        dropMove.toValue = 18.0
        dropMove.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        dropMove.removedOnCompletion = false
        dropMove.fillMode = kCAFillModeForwards
        drop.addAnimation(dropMove, forKey: "moveDown")
        
        let imageShow: CABasicAnimation = CABasicAnimation(keyPath:"transform")
        imageShow.beginTime = CACurrentMediaTime() + delay
        imageShow.duration = 0.3
        imageShow.repeatCount = 1.0
        imageShow.fromValue = NSValue(CATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0))
        imageShow.toValue = NSValue(CATransform3D:CATransform3DMakeScale(2.0, 2.0, 2.0))
        imageShow.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        imageShow.autoreverses = false
        imageShow.removedOnCompletion = false
        imageShow.fillMode = kCAFillModeForwards
        logoImageView.layer.addAnimation(imageShow, forKey: "show")
        
        let imageMove: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.y")
        imageMove.beginTime = CACurrentMediaTime() + delay
        imageMove.duration = imageShow.duration
        imageMove.toValue = 18.0
        imageMove.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        imageMove.removedOnCompletion = false
        imageMove.fillMode = kCAFillModeForwards
        logoImageView.layer.addAnimation(imageMove, forKey: "move")
    }
}