//
// Created by aleksey on 14.09.15.
// Copyright (c) 2015 aleksey chernish. All rights reserved.
//

import Foundation

class Tween {
    private weak var layer: TweenLayer!

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

    var mapper: ((value: CGFloat) -> (AnyObject))?

    init (object: UIView, key: String, from: CGFloat, to: CGFloat, duration: NSTimeInterval) {
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

    func start(delay delay: NSTimeInterval) {
        self.layer.delay = delay
        start()
    }
}

extension Tween: TweenLayerDelegate {
    func tweenLayer(layer: TweenLayer, didSetAnimatableProperty to: CGFloat) {
        if let mapper = mapper {
            object.setValue(mapper(value: to), forKey: key)
        } else {
            object.setValue(to, forKey: key)
        }
    }

    func tweenLayerDidStopAnimation(layer: TweenLayer) {
        layer.removeFromSuperlayer()
    }
}

protocol TweenLayerDelegate: class {
    func tweenLayer(layer: TweenLayer, didSetAnimatableProperty to: CGFloat) -> Void
    func tweenLayerDidStopAnimation(layer: TweenLayer) -> Void
}

class TweenLayer: CALayer {
    @NSManaged private var animatableProperty: CGFloat

    var animationDelegate: TweenLayerDelegate?

    var from: CGFloat = 0
    var to: CGFloat = 0
    var tweenDuration: NSTimeInterval = 0
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    var delay: NSTimeInterval = 0

    override class func needsDisplayForKey(event: String) -> Bool {
        return event == "animatableProperty" ? true : super.needsDisplayForKey(event)
    }

    override func actionForKey(event: String) -> CAAction? {
        if event != "animatableProperty" {
            return super.actionForKey(event)
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

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        animationDelegate?.tweenLayerDidStopAnimation(self)
    }

    override func display() {
        if let value = presentationLayer()?.animatableProperty {
            animationDelegate?.tweenLayer(self, didSetAnimatableProperty: value)
        }
    }

    func startAnimation() {
        animatableProperty = to
    }
}


