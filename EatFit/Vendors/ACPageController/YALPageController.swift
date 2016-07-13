//
//  YALPageController.swift
//  EatFit
//
//  Created by Dmitriy Demchenko on 7/12/16.
//  Copyright © 2016 aleksey chernish. All rights reserved.
//

import UIKit

typealias YALPageControllerTransitionHook = ((pageViewController: UIPageViewController, viewController: UIViewController, pageIndex: UInt) -> Void)

class YALPageController: NSObject {
    
    // declare a static var to produce a unique address as the assoc object handle
    static var YALPageControllerAssociatedObjectHandle: UInt8 = 123
    
    /*weak*/ internal var pageViewController = UIPageViewController()
    internal var viewControllers = [UIViewController]()
    internal var didFinishTransition: YALPageControllerTransitionHook?
    internal var pagingEnabled = false
    
    private /*weak*/ var scrollView = UIScrollView()
    
    override init() {
        pagingEnabled = true
    }
    
    internal func showPage(index: UInt, animated: Bool) {
        showViewController(viewControllers[Int(index)], animated: animated)
        
        if let firstControllers = viewControllers.first {
            didFinishTransition?(
                pageViewController: pageViewController,
                viewController: firstControllers,
                pageIndex: index
            )
        }
    }
    
    internal func showViewController(viewController: UIViewController, animated: Bool) {
        guard let lastViewController = pageViewController.viewControllers?.last else {
            return
        }
        
        let currentIndex = viewControllers.indexOf(lastViewController)
        let index = viewControllers.indexOf(viewController)
        
        if currentIndex == index {
            return
        }
        
        let direction: UIPageViewControllerNavigationDirection = index > currentIndex ? .Forward : .Reverse
        pageViewController.setViewControllers(
            [viewController],
            direction: direction,
            animated: animated,
            completion: { _ in
                self.scrollView.scrollEnabled = self.pagingEnabled
            }
        )
    }
    
    internal func setupViewControllers(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        guard let firstViewController = viewControllers.first else {
            return
        }
        
        pageViewController.setViewControllers(
            [firstViewController],
            direction: .Forward,
            animated: false,
            completion: nil
        )
        
        guard let pageIndex = viewControllers.indexOf(firstViewController) else {
            return
        }
        
        didFinishTransition?(
            pageViewController: pageViewController,
            viewController: firstViewController,
            pageIndex: UInt(pageIndex)
        )
    }
    
    private func setupPageViewController(pageViewController: UIPageViewController) {
        self.pageViewController = pageViewController
        
        self.pageViewController.view.subviews.forEach { view in
            if view.isKindOfClass(UIScrollView.self) {
                scrollView = view as! UIScrollView
            }
        }
    }
    
    // MARK: - Paging Enabled
    
    private func setupPagingEnabled(pagingEnabled: Bool) {
        self.pagingEnabled = pagingEnabled
        scrollView.scrollEnabled = pagingEnabled
    }
    
}

extension YALPageController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let idx = viewControllers.indexOf(viewController)
        
        if idx >= viewControllers.count - 1 {
            return nil
        }
        
        return viewControllers[idx! + 1]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let idx = viewControllers.indexOf(viewController)
        
        if idx <= 0 {
            return nil
        }
        
        return viewControllers[idx! - 1]
    }
    
}


extension YALPageController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        scrollView.pagingEnabled = pagingEnabled
        
        if let lastViewController = pageViewController.viewControllers?.last where lastViewController != previousViewControllers.last {
            
            let lastIndex = viewControllers.indexOf(lastViewController)
            
            didFinishTransition?(
                pageViewController: pageViewController,
                viewController: lastViewController,
                pageIndex: UInt(lastIndex!)
            )
        }
    }
    
}