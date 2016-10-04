//
//  CAAnimationGroup+Sequence.swift
//  EatFit
//
// Created by aleksey on 14.09.15.
// Copyright (c) 2015 aleksey chernish. All rights reserved.
//

import UIKit

class Tween {
    
    fileprivate weak var layer: TweenLayer!

    let object: UIView
    let key: String

    var timingFunction: CAMediaTimingFunction {
        set {
            layer.timingFunction = newValue
        }
        get {
            return layer.timingFunction
        }
    }

    var mapper: ((CGFloat) -> Any)?

    init (object: UIView, key: String, from: CGFloat, to: CGFloat, duration: TimeInterval) {
        self.object = object
        self.key = key

        layer = {
            let layer = TweenLayer()
            layer.from = from
            layer.to = to
            layer.tweenDuration = duration
            layer.animationDelegate = self
            object.layer.addSublayer(layer)

            return layer
        }()
    }

    convenience init (object: UIView, key: String, to: CGFloat) {
        self.init(object: object, key: key, from: 0, to: to, duration: 0.5)
    }

    func start() {
        layer.startAnimation()
    }

    func start(delay: TimeInterval) {
        layer.delay = delay
        start()
    }
}

extension Tween: TweenLayerDelegate {
    
    func tweenLayer(_ layer: TweenLayer, didSetAnimatableProperty to: CGFloat) {
        if let mapper = mapper {
            object.setValue(mapper(to), forKey: key)
        } else {
            object.setValue(to, forKey: key)
        }
    }

    func tweenLayerDidStopAnimation(_ layer: TweenLayer) {
        layer.removeFromSuperlayer()
    }
}

protocol TweenLayerDelegate: class {
    
    func tweenLayer(_ layer: TweenLayer, didSetAnimatableProperty to: CGFloat) -> Void
    func tweenLayerDidStopAnimation(_ layer: TweenLayer) -> Void
}

class TweenLayer: CALayer {
    
    @NSManaged fileprivate var animatableProperty: CGFloat

    var animationDelegate: TweenLayerDelegate?

    var from: CGFloat = 0
    var to: CGFloat = 0
    var tweenDuration: TimeInterval = 0
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    var delay: TimeInterval = 0

    override class func needsDisplay(forKey event: String) -> Bool {
        return event == "animatableProperty" ? true : super.needsDisplay(forKey: event)
    }

    override func action(forKey event: String) -> CAAction? {
        if event != "animatableProperty" {
            return super.action(forKey: event)
        }

        let animation = CABasicAnimation(keyPath: event)
        animation.timingFunction = timingFunction
        animation.fromValue = from
        animation.toValue = to
        animation.duration = tweenDuration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.delegate = self

        return animation;
    }

    override func display() {
        if let value = presentation()?.animatableProperty {
            animationDelegate?.tweenLayer(self, didSetAnimatableProperty: value)
        }
    }

    func startAnimation() {
        animatableProperty = to
    }
}

extension TweenLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDelegate?.tweenLayerDidStopAnimation(self)
    }
}
