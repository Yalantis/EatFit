//
//  EatFitPageControl.swift
//  EatFit
//
//  Created by aleksey on 11.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class EatFitPageControl: UIView {

    var pagesCount: Int = 0 {
        didSet {
            layoutButtons()
        }
    }
    
    fileprivate var buttons: [UIView] = []
    
    func selectButton(at index:Int) {
        if index > buttons.count - 1 {
            return
        }
        
        for button in buttons {
            button.backgroundColor = UIColor(red: 185 / 255, green: 185 / 255, blue: 185 / 255, alpha: 1)
        }
        buttons[index].backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
    }
    
    
    fileprivate func layoutButtons () {
        for button in buttons {
            button.removeFromSuperview()
        }
        buttons.removeAll(keepingCapacity: false)
        
        if pagesCount == 0 {
            return
        }
        
        let buttonWidth: CGFloat = 10
        let gapWidth: CGFloat = 8
        let count = CGFloat(pagesCount)
        let totalWidth = buttonWidth * count + gapWidth * (count - 1)
        var startX = (frame.width - totalWidth) / 2
        for i in 0..<pagesCount {
            let button = UIButton(frame: CGRect(x: startX, y: 0, width: buttonWidth, height: buttonWidth))
            button.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
            button.layer.cornerRadius = buttonWidth / 2
            button.layer.masksToBounds = true
            button.tag = i
            self.addSubview(button)
            buttons.append(button)
            
            startX += buttonWidth + gapWidth
        }
    }
}
