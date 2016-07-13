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
    
    var viewControllers = [UIViewController]()
    var didFinishTransition: YALPageControllerTransitionHook?
    var pagingEnabled = true
    
    weak var pageViewController: UIPageViewController!
    private weak var scrollView: UIScrollView!
    
    
    func showPage(index: UInt, animated: Bool) {
        showViewController(viewControllers[Int(index)], animated: animated)
        
        if let pageViewController = pageViewController, firstControllers = viewControllers.first {
            didFinishTransition?(
                pageViewController: pageViewController,
                viewController: firstControllers,
                pageIndex: index
            )
        }
    }
    
    func showViewController(viewController: UIViewController, animated: Bool) {
        guard let pageViewController = pageViewController else {
            return
        }
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
                if let _ = self.scrollView {
                    self.scrollView.scrollEnabled = self.pagingEnabled
                }
            }
        )
    }
    
    func setupViewControllers(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        guard let pageViewController = pageViewController else {
            return
        }
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
    
    func setupPageViewController(pageViewController: UIPageViewController) {
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
        if let _ = scrollView {
            scrollView.scrollEnabled = pagingEnabled
        }
    }
    
}

extension YALPageController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.indexOf(viewController) else {
            return nil
        }
        
        if index >= viewControllers.count - 1 {
            return nil
        }
        
        return viewControllers[index + 1]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.indexOf(viewController) else {
            return nil
        }
        
        if index <= 0 {
            return nil
        }
        
        return viewControllers[index - 1]
    }
    
}


extension YALPageController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let _ = scrollView {
            scrollView.pagingEnabled = pagingEnabled
        }
        
        if let lastViewController = pageViewController.viewControllers?.last where lastViewController != previousViewControllers.last {
            
            if let lastIndex = viewControllers.indexOf(lastViewController) {
                didFinishTransition?(
                    pageViewController: pageViewController,
                    viewController: lastViewController,
                    pageIndex: UInt(lastIndex)
                )
            }
        }
    }
    
}