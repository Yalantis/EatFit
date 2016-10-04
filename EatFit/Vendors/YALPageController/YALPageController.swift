//
//  YALPageController.swift
//  EatFit
//
//  Created by Dmitriy Demchenko on 7/12/16.
//  Copyright © 2016 aleksey chernish. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


typealias YALPageControllerTransitionHook = ((_ pageViewController: UIPageViewController, _ viewController: UIViewController, _ pageIndex: Int) -> Void)

class YALPageController: NSObject {
    
    // declare a static var to produce a unique address as the assoc object handle
    static var YALPageControllerAssociatedObjectHandle: UInt8 = 123
    
    var viewControllers = [UIViewController]()
    var didFinishTransition: YALPageControllerTransitionHook?
    var pagingEnabled = true
    
    weak var pageViewController: UIPageViewController!
    fileprivate weak var scrollView: UIScrollView!
    
    
    func showPage(_ index: Int, animated: Bool) {
        showViewController(viewControllers[Int(index)], animated: animated)
        
        if let pageViewController = pageViewController, let firstControllers = viewControllers.first {
            didFinishTransition?(
                pageViewController,
                firstControllers,
                index
            )
        }
    }
    
    func showViewController(_ viewController: UIViewController, animated: Bool) {
        guard let pageViewController = pageViewController else {
            return
        }
        guard let lastViewController = pageViewController.viewControllers?.last else {
            return
        }
        
        let currentIndex = viewControllers.index(of: lastViewController)
        let index = viewControllers.index(of: viewController)
        
        if currentIndex == index {
            return
        }
        
        let direction: UIPageViewControllerNavigationDirection = index > currentIndex ? .forward : .reverse
        pageViewController.setViewControllers(
            [viewController],
            direction: direction,
            animated: animated,
            completion: { _ in
                if let _ = self.scrollView {
                    self.scrollView.isScrollEnabled = self.pagingEnabled
                }
            }
        )
    }
    
    func setupViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        guard let pageViewController = pageViewController else {
            return
        }
        guard let firstViewController = viewControllers.first else {
            return
        }
        
        pageViewController.setViewControllers(
            [firstViewController],
            direction: .forward,
            animated: false,
            completion: nil
        )
        
        guard let pageIndex = viewControllers.index(of: firstViewController) else {
            return
        }
        
        didFinishTransition?(
            pageViewController,
            firstViewController,
            pageIndex
        )
    }
    
    func setupPageViewController(_ pageViewController: UIPageViewController) {
        self.pageViewController = pageViewController
        
        self.pageViewController.view.subviews.forEach { view in
            if view.isKind(of: UIScrollView.self) {
                scrollView = view as! UIScrollView
            }
        }
    }
    
    // MARK: - Paging Enabled
    
    fileprivate func setupPagingEnabled(_ pagingEnabled: Bool) {
        self.pagingEnabled = pagingEnabled
        if let _ = scrollView {
            scrollView.isScrollEnabled = pagingEnabled
        }
    }
    
}

extension YALPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.index(of: viewController) else {
            return nil
        }
        
        if index >= viewControllers.count - 1 {
            return nil
        }
        
        return viewControllers[index + 1]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.index(of: viewController) else {
            return nil
        }
        
        if index <= 0 {
            return nil
        }
        
        return viewControllers[index - 1]
    }
    
}

extension YALPageController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let _ = scrollView {
            scrollView.isPagingEnabled = pagingEnabled
        }
        
        if let lastViewController = pageViewController.viewControllers?.last , lastViewController != previousViewControllers.last {
            
            if let lastIndex = viewControllers.index(of: lastViewController) {
                didFinishTransition?(
                    pageViewController,
                    lastViewController,
                    lastIndex
                )
            }
        }
    }
}
