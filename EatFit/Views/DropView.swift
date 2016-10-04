//
//  DropView.swift
//  EatFit
//
//  Created by aleksey on 08.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class DropView: UIView {
    
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
    let logoImageView = UIImageView()

    var color: UIColor {
        set {
            drop.fillColor = newValue.cgColor
            logoImageView.tintColor = newValue
        }
        get {
            return UIColor(cgColor: drop.fillColor!)
        }
    }
    
    let drop = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(logoImageView)
        logoImageView.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        drop.frame = CGRect(
            x: (ceil(bounds.width) - chartThickness) / 2.0,
            y: -(chartThickness / 2.0),
            width: chartThickness,
            height: chartThickness
        )
        drop.path = UIBezierPath(ovalIn: drop.bounds).cgPath
        
        let size: CGFloat = 30
        logoImageView.frame = CGRect(x: (bounds.width - size) / 2.0, y: -chartThickness, width: size, height: size)
    }
    
    func animateDrop (delay: TimeInterval) {
        layer.addSublayer(drop)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.performDropAnimation()
        }
    }
    
    func performDropAnimation () {
        let dropFall: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.duration = 0.3
            animation.toValue = frame.height - chartThickness
            animation.timingFunction = fallEaseIn
            return animation
        }()
        
        let dropLay: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.duration = 0.05
            animation.toValue = dropFall.toValue
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            return animation
        }()
                
        let dropJump: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.duration = dropFall.duration * 1.5
            animation.toValue = 0.0
            animation.timingFunction = fallEaseOut
            return animation
        }()
    
        let group: CAAnimationGroup = CAAnimationGroup(of: [dropFall, dropLay, dropJump])
        drop.add(group, forKey: "move")
        
        let dropSmash: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.scale.y")
            animation.beginTime = CACurrentMediaTime() + dropLay.beginTime - 0.1
            animation.duration = dropLay.duration
            animation.repeatCount = 1.0
            animation.fromValue = 1.0
            animation.toValue = 0.6
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.autoreverses = true
            animation.isRemovedOnCompletion = false
            return animation
        }()
        
        drop.add(dropSmash, forKey: "smash")
    }
    
    func animateLogo (delay: TimeInterval) {
        logoImageView.layer.removeAllAnimations()
        logoImageView.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        
        let dropDisappear: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.beginTime = CACurrentMediaTime() + delay
            animation.duration = 0.3
            animation.repeatCount = 1.0
            animation.fromValue = 1.0
            animation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 0.0))
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.autoreverses = false
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            return animation
        }()
        
        drop.add(dropDisappear, forKey: "disappear")
        
        let dropMove: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.beginTime = CACurrentMediaTime() + delay
            animation.duration = dropDisappear.duration
            animation.toValue = 18.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            return animation
        }()
        drop.add(dropMove, forKey: "moveDown")
        
        let imageShow: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath: "transform")
            animation.beginTime = CACurrentMediaTime() + delay
            animation.duration = 0.3
            animation.repeatCount = 1.0
            animation.fromValue = NSValue(caTransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0))
            animation.toValue = NSValue(caTransform3D:CATransform3DMakeScale(2.0, 2.0, 2.0))
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.autoreverses = false
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            return animation
        }()
        logoImageView.layer.add(imageShow, forKey: "show")
        
        let imageMove: CABasicAnimation = {
            let animation = CABasicAnimation(keyPath:"transform.translation.y")
            animation.beginTime = CACurrentMediaTime() + delay
            animation.duration = imageShow.duration
            animation.toValue = 18.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            return animation
        }()
        logoImageView.layer.add(imageMove, forKey: "move")
    }
}
