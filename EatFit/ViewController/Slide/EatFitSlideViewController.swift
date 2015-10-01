//
//  СhartViewController.swift
//  Pager
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class EatFitSlideViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionView: SlideLabelView!
    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var chartView: RoundChartView!
    @IBOutlet private weak var dropView: DropView!
    @IBOutlet private weak var descriptionCenterConstraint: NSLayoutConstraint!
    
    private var animationPlayed = false
    
    var chartThickness: CGFloat = 0 {
        didSet {
            dropView.chartThickness = chartThickness
            chartView.chartThickness = chartThickness
        }
    }

    var chartColor: UIColor = UIColor.blueColor() {
        didSet {
            chartView.chartColor = chartColor
            dropView.color = chartColor
        }
    }

    var chartTitle: String = "" {
        didSet {
            titleLabel.text = chartTitle
        }
    }
    
    var chartDescription: String = "" {
        didSet {
            descriptionView.text = chartDescription
        }
    }
    
    var logoImage: UIImage = UIImage() {
        didSet {
           dropView.logo = logoImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        }
    }
    
    var percentage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = chartThickness
        self.view.layer.masksToBounds = true
    }
    
    func animate () {
        if animationPlayed {return}
        animationPlayed = true
        dropView.animateDrop(delay: 0)
        chartView.show(percentage: percentage, delay: 0.9)
        animatePercentageLabel(delay: 0.9)
        descriptionView.animate(delay: 2.7)
        dropView.animateLogo(delay: 2.7)
    }


    func animatePercentageLabel (delay delay: NSTimeInterval) {
        let tween = Tween(object: percentageLabel, key: "text", to: CGFloat(percentage))
//        let tween = Tween(object: percentageLabel, key: "text", from: 0, to: 50, duration: 3)
//        tween.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.4, 0.4, 1)
        tween.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        tween.mapper = { value in
            return value == 0 ? "" : String(format: "%0.f%%", value)
        }

        tween.start(delay: delay)
    }
}




