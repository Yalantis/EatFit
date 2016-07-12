//
//  UIView+YALFrames.swift
//  Pager
//
//  Created by Dmitriy Demchenko on 7/12/16.
//  Copyright © 2016 Dmitriy Demchenko. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - GETTERS
    
    func yal_x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func yal_y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func yal_width() -> CGFloat {
        return self.frame.size.width
    }
    
    func yal_height() -> CGFloat {
        return self.frame.size.height
    }
    
    func yal_rightEdge() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func yal_bottomEdge() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    // MARK: - MOVE
    // MARK: absolute
    
    func yal_setX(x: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
        return self
    }
    
    func yal_setY(y: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
        return self
    }
    
    func yal_setOrigin(origin: CGPoint) -> UIView {
        var frame = self.frame
        frame.origin = origin
        self.frame = frame
        return self
    }
    
    func yal_placeBottomAt(bottomY: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = bottomY - self.frame.height
        self.frame = frame
        return self
    }
    
    func yal_placeRightAt(rightX: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = rightX - self.frame.width
        self.frame = frame
        return self
    }
    
    // MARK: offset
    
    func yal_moveX(x: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x += x
        self.frame = frame
        return self
    }
    
    func yal_moveY(y: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y += y
        self.frame = frame
        return self
    }
    
    // MARK: - CHANGE DIMENSIONS    
    // MARK: absolute
    
    func yal_setWidth(width: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
        return self
    }
    
    func yal_setHeight(height: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
        return self
    }
    
    func yal_moveBottomEdgeTo(bottomY: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height = bottomY - frame.origin.y
        self.frame = frame
        return self
    }
    
    func yal_moveRightEdgeTo(rightX: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width = rightX - frame.origin.x
        self.frame = frame
        return self
    }
    
    // MARK: - relative
    
    func yal_trimTop(topOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y += topOffset
        frame.size.height -= topOffset
        self.frame = frame
        return self
    }
    
    func yal_trimBottom(bottomOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height -= bottomOffset
        self.frame = frame
        return self
    }
    
    func yal_trimLeft(leftOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x += leftOffset
        frame.size.width -= leftOffset
        self.frame = frame
        return self
    }
    
    func yal_trimRight(rightOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width -= rightOffset
        self.frame = frame
        return self
    }
    
    func yal_moveToCenterOf(view: UIView) -> UIView {
        var frame = self.frame
        let center = view.center
        frame.origin.x = center.x - self.yal_width() / 2
        frame.origin.y = center.y - self.yal_height() / 2
        self.frame = frame
        return self
    }

}