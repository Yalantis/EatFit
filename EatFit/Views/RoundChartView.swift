//
//  RoundChartView.swift
//  EatFit
//
//  Created by aleksey on 07.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class RoundChartView: UIView {
    
    var chartThickness: CGFloat = 0 {
        didSet {
            greyChart.lineWidth = chartThickness
            colorChart.lineWidth = chartThickness
        }
    }
    
    var chartColor: UIColor {
        set {
            colorChart.strokeColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor:colorChart.strokeColor!)
        }
    }
    
    let easeOut = CAMediaTimingFunction(controlPoints: 0, 0.4, 0.4, 1)
    
    fileprivate let greyChart: CAShapeLayer = {
        let circle: CAShapeLayer = CAShapeLayer()
        circle.position = .zero
        circle.lineCap = kCALineCapRound
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        circle.strokeEnd = 0
        return circle
    }()
    
    fileprivate let colorChart: CAShapeLayer = {
        let circle: CAShapeLayer = CAShapeLayer()
        circle.position = .zero
        circle.lineCap = kCALineCapRound
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeEnd = 0
        circle.strokeColor = UIColor.red.cgColor
        return circle
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.addSublayer(greyChart)
        layer.addSublayer(colorChart)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path: CGPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.size.width / 2).cgPath
        colorChart.path = path
        greyChart.path = path
    }

    func show(percentage: Int, delay: TimeInterval) {
        let showTime: TimeInterval = 0.8
    
        let colorChartShow = animation(percentage: percentage, duration: 0.6, timingFunction: easeOut)
        colorChartShow.beginTime = delay
        
        let splashDuration: TimeInterval = 0.2
        let toValue: Int = min(100, percentage + 10)
        
        let splash: CABasicAnimation = animation(percentage: toValue, duration: splashDuration, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        splash.beginTime = colorChartShow.beginTime + colorChartShow.duration + showTime
        
        let colorHide: CABasicAnimation = animation(percentage: -1, duration: 0.3, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        colorHide.beginTime = splash.beginTime + splash.duration
        
        let colorGroup: CAAnimationGroup = CAAnimationGroup()
        colorGroup.duration = delay + colorChartShow.duration + showTime + splashDuration + colorHide.duration
        colorGroup.animations = [colorChartShow, splash, colorHide]
        colorGroup.fillMode = kCAFillModeForwards
        colorGroup.isRemovedOnCompletion = false
        
        colorChart.add(colorGroup, forKey: "show")
        
        let greyChartShow = animation(percentage: 100, duration: 0.6, timingFunction:easeOut)
        greyChartShow.beginTime = colorChartShow.beginTime
        
        let greyChartHide = animation(percentage: -1, duration: 0.3, timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut));
        greyChartHide.beginTime = colorHide.beginTime
        
        let greyGroup: CAAnimationGroup = CAAnimationGroup()
        greyGroup.animations = [greyChartShow, greyChartHide]
        greyGroup.duration = colorGroup.duration
        
        greyChart.add(greyGroup, forKey: "show")
    }

    func reset () {
        colorChart.removeAllAnimations()
        greyChart.removeAllAnimations()
    }

    func animation(percentage: Int, duration: TimeInterval, timingFunction:CAMediaTimingFunction) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath:"strokeEnd")
        animation.duration = duration
        animation.repeatCount = 1
        animation.toValue = Float(percentage) / 100
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = timingFunction
        
        return animation
    }
}
