//
//  UIView+YALFrames.swift
//  EatFit
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
    
    @discardableResult
    func yal_setX(_ x: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_setY(_ y: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_setOrigin(_ origin: CGPoint) -> UIView {
        var frame = self.frame
        frame.origin = origin
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_placeBottomAt(_ bottomY: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = bottomY - self.frame.height
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_placeRightAt(_ rightX: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y = rightX - self.frame.width
        self.frame = frame
        return self
    }
    
    // MARK: offset
    
    @discardableResult
    func yal_moveX(_ x: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x += x
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_moveY(_ y: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y += y
        self.frame = frame
        return self
    }
    
    // MARK: - CHANGE DIMENSIONS    
    // MARK: absolute
    
    @discardableResult
    func yal_setWidth(_ width: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_setHeight(_ height: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_moveBottomEdgeTo(_ bottomY: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height = bottomY - frame.origin.y
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_moveRightEdgeTo(_ rightX: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width = rightX - frame.origin.x
        self.frame = frame
        return self
    }
    
    // MARK: - relative
    
    @discardableResult
    func yal_trimTop(_ topOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y += topOffset
        frame.size.height -= topOffset
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_trimBottom(_ bottomOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.height -= bottomOffset
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_trimLeft(_ leftOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x += leftOffset
        frame.size.width -= leftOffset
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_trimRight(_ rightOffset: CGFloat) -> UIView {
        var frame = self.frame
        frame.size.width -= rightOffset
        self.frame = frame
        return self
    }
    
    @discardableResult
    func yal_moveToCenterOf(_ view: UIView) -> UIView {
        var frame = self.frame
        let center = view.center
        frame.origin.x = center.x - self.yal_width() / 2
        frame.origin.y = center.y - self.yal_height() / 2
        self.frame = frame
        return self
    }

}
