//
//  СhartViewController.swift
//  EatFit
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class EatFitSlideViewController: UIViewController {
    
    var chartThickness: CGFloat = 0 {
        didSet {
            dropView.chartThickness = chartThickness
            chartView.chartThickness = chartThickness
        }
    }

    var chartColor: UIColor = .blue {
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
           dropView.logo = logoImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }
    
    var backgroundColor: UIColor = .white {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    var percentage = 0
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionView: SlideLabelView!
    @IBOutlet fileprivate weak var percentageLabel: UILabel!
    @IBOutlet fileprivate weak var backgroundView: UIView!
    @IBOutlet fileprivate weak var chartView: RoundChartView!
    @IBOutlet fileprivate weak var dropView: DropView!
    @IBOutlet fileprivate weak var descriptionCenterConstraint: NSLayoutConstraint!
    
    fileprivate var animationPlayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = chartThickness
        view.layer.masksToBounds = true
    }
    
    func animate () {
        guard !animationPlayed else { return }
        
        animationPlayed = true
        dropView.animateDrop(delay: 0)
        chartView.show(percentage: percentage, delay: 0.9)
        animatePercentageLabel(delay: 0.9)
        descriptionView.animate(delay: 2.7)
        dropView.animateLogo(delay: 2.7)
    }

    func animatePercentageLabel (delay: TimeInterval) {
        let tween = Tween(object: percentageLabel, key: "text", to: CGFloat(percentage))
        tween.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        tween.mapper = { value in
            return value == 0 ? "" : String(format: "%0.f%%", value)
        }

        tween.start(delay: delay)
    }
}
