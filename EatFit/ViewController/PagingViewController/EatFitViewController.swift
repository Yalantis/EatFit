//
//  EatFitViewcontroller.swift
//  EatFit
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

protocol EatFitViewControllerDataSource: class {
    
    func numberOfPagesForPagingViewController(_ controller: EatFitViewController) -> Int
    func chartColorForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> UIColor
    func percentageForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> Int
    func titleForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> String
    func descriptionForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> String
    func logoForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> UIImage
    func chartThicknessForPagingViewController(_ controller: EatFitViewController) -> CGFloat
    
    func backgroundColorForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> UIColor
}

extension EatFitViewControllerDataSource {
    
    func backgroundColorForPage(_ index: Int, forPagingViewController controller: EatFitViewController) -> UIColor {
        return .white
    }
}

class EatFitViewController: UIViewController {
    
    weak var dataSource: EatFitViewControllerDataSource!

    @IBOutlet weak var pageViewContainer: UIView!
    @IBOutlet weak var pageControl: EatFitPageControl!
    
    fileprivate var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.view.backgroundColor = .clear
        pageViewContainer.yal_addSubview(pageViewController.view, options: .overlay)
        pageControl.pagesCount = dataSource.numberOfPagesForPagingViewController(self)
        pageControl.selectButton(at: 0)
        reloadData()
    }
    
    func reloadData() {
        pageViewController.yal_setDidFinishTransition { pageController, viewController, index in
            self.pageControl.selectButton(at: index)
            let slide = viewController as! EatFitSlideViewController
            slide.animate()
        }
        
        var pages = [UIViewController]()
        
        for index in 0..<dataSource.numberOfPagesForPagingViewController(self) {
            let viewController = EatFitSlideViewController(nibName:"EatFitSlideViewController", bundle: nil)
            viewController.loadView()
            viewController.backgroundColor = dataSource.backgroundColorForPage(index, forPagingViewController: self)
            viewController.chartTitle = dataSource.titleForPage(index, forPagingViewController: self)
            viewController.chartColor = dataSource.chartColorForPage(index, forPagingViewController: self)
            viewController.chartDescription = dataSource.descriptionForPage(index, forPagingViewController: self)
            viewController.percentage = dataSource.percentageForPage(index, forPagingViewController: self)
            viewController.logoImage = dataSource.logoForPage(index, forPagingViewController: self)
            viewController.chartThickness = dataSource.chartThicknessForPagingViewController(self)
            pages.append(viewController)

            pageControl.selectButton(at: 0)
            pageViewController.yal_setViewControllers(pages)
        }
    }
}
