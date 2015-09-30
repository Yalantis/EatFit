//
//  EatFitViewcontroller.swift
//  Pager
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

protocol EatFitViewControllerDataSource {
    func numberOfPagesForPagingViewController(controller: EatFitViewController) -> Int
    func chartColorForPage(index: Int, forPagingViewController controller: EatFitViewController) -> UIColor
    func percentageForPage(index: Int, forPagingViewController controller: EatFitViewController) -> Int
    func titleForPage(index: Int, forPagingViewController controller: EatFitViewController) -> String
    func descriptionForPage(index: Int, forPagingViewController controller: EatFitViewController) -> String
    func logoForPage(index: Int, forPagingViewController controller: EatFitViewController) -> UIImage
    func chartThicknessForPagingViewController(controller: EatFitViewController) -> CGFloat
}

class EatFitViewController : UIViewController {
    var chartDataSource: EatFitViewControllerDataSource!

    @IBOutlet
    weak var pageViewContainer: UIView!
    
    @IBOutlet
    weak var pageControl: EatFitPageControl!
    
    private var pageViewController: UIPageViewController = {
        let controller = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options:nil)
        
        return controller
    }()
    
    class func controller() -> EatFitViewController {
        return EatFitViewController(nibName: "EatFitViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.view.backgroundColor = UIColor.clearColor()
        pageViewContainer.tlk_addSubview(pageViewController.view, options: TLKAppearanceOptions.Overlay)
        pageControl.pagesCount = chartDataSource.numberOfPagesForPagingViewController(self)
        pageControl.selectButton(0)
        reloadData()
    }
    
    func reloadData() {
        pageViewController.ac_setDidFinishTransition({ (pageController, viewController, idx) -> Void in
            self.pageControl.selectButton(Int(idx))
            let slide = viewController as! EatFitSlideViewController
            slide.animate()
        })
        
        var pages: [UIViewController] = Array()
        
        for idx in 0..<chartDataSource.numberOfPagesForPagingViewController(self) {
            let vc = EatFitSlideViewController(nibName:"EatFitSlideViewController", bundle: nil)
            vc.loadView()
            vc.chartTitle = chartDataSource.titleForPage(idx, forPagingViewController: self)
            vc.chartColor = chartDataSource.chartColorForPage(idx, forPagingViewController: self)
            vc.chartDescription = chartDataSource.descriptionForPage(idx, forPagingViewController: self)
            vc.percentage = chartDataSource.percentageForPage(idx, forPagingViewController: self)
            vc.logoImage = chartDataSource.logoForPage(idx, forPagingViewController: self)
            vc.chartThickness = chartDataSource.chartThicknessForPagingViewController(self)
            pages.append(vc)

            pageControl.selectButton(0)
            pageViewController.ac_setViewControllers(pages)
        }
    }
}