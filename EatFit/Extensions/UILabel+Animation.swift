//
//  UILabel+Animation.swift
//  EatFit
//
//  Created by aleksey on 08.06.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

extension UILabel {
    
    func animateAdding(_ duration: Double) {
        if let text = text {
            iterateAdding(text as NSString, index: 0, delay: duration / Double(text.characters.count))
        }
    }
    
    fileprivate func iterateAdding(_ text: NSString, index: Int, delay: Double) {
        let substring = text.substring(to: index)
        self.text = substring
        
        if text as String != substring {
            let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

            DispatchQueue.main.asyncAfter(deadline: time) {
                self.iterateAdding(text, index: index + 1, delay: delay)
            }
        }
    }
    
    func animateAlpha(duration: Double, delay: Double) {
        if let text = text {
            
            let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            let originalFontColor = self.textColor
            
            textColor = UIColor.clear
            DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                self.iterateAlpha(text as NSString, index: 0, delay: duration / Double(text.characters.count), font: self.font, color: originalFontColor!)
            }
        }
    }
    
    fileprivate func iterateAlpha(_ text: NSString, index: Int, delay: Double, font: UIFont, color: UIColor) {
        let substringToShow = text.substring(to: index);
        let substringToHide = text.substring(from: index);
        
        let showAttrs = [NSFontAttributeName: font,
            NSForegroundColorAttributeName: color]
        let showString = NSAttributedString(string: substringToShow, attributes: showAttrs)
                
        let hideAttrs = [NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.clear]
                
        let hideString = NSAttributedString(string: substringToHide, attributes: hideAttrs)
        
        let result = NSMutableAttributedString()
        result.append(showString)
        result.append(hideString)
                
        self.attributedText = result
            
        if substringToHide.characters.count != 0 {
            let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

            DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                self.iterateAlpha(text, index: index + 1, delay: delay, font: font, color: color)
            }
        }
    }
}
