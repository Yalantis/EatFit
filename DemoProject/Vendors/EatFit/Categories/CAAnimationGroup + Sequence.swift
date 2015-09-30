//
//  CAAnimationGroup + Sequence.swift
//  Pager
//
//  Created by aleksey on 08.07.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import Foundation
import QuartzCore

extension CAAnimationGroup {
    convenience init(sequence: [CABasicAnimation]) {
        self.init()
        self.animations = chain(sequence)
        
        for animation in animations! {
            duration += animation.duration
        }
    }
    
    func chain(animations: [CABasicAnimation]) -> [CABasicAnimation] {
        for i in 0..<animations.count {
            if i == 0 {continue}
            chain(animations[i], previousAnimation: animations[i - 1])
        }
        return animations
    }
    
    func chain (animation: CABasicAnimation, previousAnimation: CABasicAnimation) {
        animation.beginTime = previousAnimation.beginTime + previousAnimation.duration
        animation.fromValue = previousAnimation.toValue
    }
}
