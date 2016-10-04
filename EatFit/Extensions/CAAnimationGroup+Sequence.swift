//
//  CAAnimationGroup+Sequence.swift
//  EatFit
//
//  Created by aleksey on 08.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import Foundation
import QuartzCore

extension CAAnimationGroup {
    
    convenience init(of sequence: [CABasicAnimation]) {
        self.init()
        
        let animations = chain(of: sequence)
        for animation in animations {
            duration += animation.duration
        }
        self.animations = animations
    }
    
    func chain(of animations: [CABasicAnimation]) -> [CABasicAnimation] {
        for i in 0..<animations.count {
            if i == 0 {continue}
            chain(from: animations[i], to: animations[i - 1])
        }
        return animations
    }
    
    func chain(from animation: CABasicAnimation, to previousAnimation: CABasicAnimation) {
        animation.beginTime = previousAnimation.beginTime + previousAnimation.duration
        animation.fromValue = previousAnimation.toValue
    }
}
