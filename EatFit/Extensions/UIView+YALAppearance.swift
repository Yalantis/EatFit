//
//  UIView+Appearance.swift
//  EatFit
//
//  Created by Dmitriy Demchenko on 7/12/16.
//  Copyright © 2016 Dmitriy Demchenko. All rights reserved.
//

import UIKit

private typealias SubviewTreeModifier = ((Void) -> UIView)

public struct AppearanceOptions: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static let overlay = AppearanceOptions(rawValue: 1 << 0)
    public static let useAutoresize = AppearanceOptions(rawValue: 1 << 1)
}

extension UIView {
    
    fileprivate func yal_addSubviewUsingOptions(_ options: AppearanceOptions, modifier: SubviewTreeModifier) {
        let subview = modifier()
        if options.union(.overlay) == .overlay {
            if options.union(.useAutoresize) != .useAutoresize {
                subview.translatesAutoresizingMaskIntoConstraints = false
                let views = dictionaryOfNames([subview])
                
                let horisontalConstraints = NSLayoutConstraint.constraints(
                    withVisualFormat: "|[subview]|",
                    options: [],
                    metrics: nil,
                    views: views
                )
                addConstraints(horisontalConstraints)
                
                let verticalConstraints = NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[subview]|",
                    options: [],
                    metrics: nil,
                    views: views
                )
                addConstraints(verticalConstraints)
                
            } else {
                frame = bounds
                subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
        }
    }
    
    fileprivate func dictionaryOfNames(_ views:[UIView]) -> [String: UIView] {
        var container = [String: UIView]()
        for (_, value) in views.enumerated() {
            container["subview"] = value
        }
        return container
    }
    
    // MARK: - Interface methods
    
    public func yal_addSubview(_ subview: UIView, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        yal_addSubviewUsingOptions(options) { [weak self] in
            self?.addSubview(subview)
            return subview
        }
    }
    
    public func yal_insertSubview(_ subview: UIView, index: Int, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        yal_addSubviewUsingOptions(options) { [weak self] in
            self?.insertSubview(subview, at: index)
            return subview
        }
    }
    
}
