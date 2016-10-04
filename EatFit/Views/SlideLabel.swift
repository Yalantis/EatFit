//
//  SlideLabel.swift
//  EatFit
//
//  Created by aleksey on 08.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class SlideLabelView: UIView {
    
    fileprivate var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 47/255, green: 49/255, blue: 49/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        return label
    }()
    
    var text: String? {
        set {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(label)
        label.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
        label.yal_trimLeft(40)
        label.yal_trimRight(40)
    }
    
    func animate (delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.label.isHidden = false
        }

        let labelShift: CABasicAnimation = {
            let labelShift = CABasicAnimation(keyPath:"transform.translation.x")
            labelShift.beginTime = CACurrentMediaTime() + delay
            labelShift.duration = 0.7
            labelShift.fromValue = 50
            labelShift.toValue = 0
            labelShift.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
            return labelShift
        }()
        label.layer.add(labelShift, forKey: "shift")
        
        label.animateAlpha(duration: 0.5, delay: delay)
    }
}
