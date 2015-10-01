//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACPageController.h"

@interface ACPageController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ACPageController

- (instancetype)init {
    if (self = [super init]) {
        [self setPagingEnabled:YES];
    }
    
    return self;
}
- (void)showPage:(NSUInteger)index animated:(BOOL)animated {
    [self showViewController:_viewControllers[index] animated:animated];
    ac_safeBlockCall(_didFinishTransition, _pageViewController, _viewControllers.firstObject, [_viewControllers indexOfObject:_viewControllers.firstObject]);
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSUInteger currentIndex = [_viewControllers indexOfObject:[_pageViewController.viewControllers lastObject]];
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == currentIndex) return;

    UIPageViewControllerNavigationDirection direction = index > currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;

    [_pageViewController setViewControllers:@[viewController]
                                  direction:direction
                                   animated:animated
                                 completion:^(BOOL finished) {
        [self.scrollView setScrollEnabled:_pagingEnabled];
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [_pageViewController setViewControllers:@[[_viewControllers firstObject]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    ac_safeBlockCall(_didFinishTransition, _pageViewController, _viewControllers.firstObject, [_viewControllers indexOfObject:_viewControllers.firstObject]);
}

- (void)setPageViewController:(UIPageViewController *)pageViewController {
    _pageViewController = pageViewController;

    for (UIScrollView *view in _pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            _scrollView = view;
        }
    }
}

#pragma mark - Paging Enabled

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;
    [_scrollView setScrollEnabled:_pagingEnabled];
}

#pragma mark - UIPageViewController delegate and data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    if (!viewController) return _viewControllers[0];

    NSInteger idx = [_viewControllers indexOfObject:viewController];
    NSParameterAssert(idx != NSNotFound);
    if (idx >= [_viewControllers count] - 1) {
        return nil;
    }

    return _viewControllers[(NSUInteger)(idx + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    if (!viewController) {
        return _viewControllers[0];
    }

    NSInteger idx = [_viewControllers indexOfObject:viewController];
    NSParameterAssert(idx != NSNotFound);
    if (idx <= 0) {
        return nil;
    }

    return _viewControllers[(NSUInteger)(idx - 1)];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    [_scrollView setPagingEnabled:_pagingEnabled];
    if (pageViewController.viewControllers.lastObject != previousViewControllers.lastObject) {
        ac_safeBlockCall(_didFinishTransition, pageViewController, pageViewController.viewControllers.lastObject, [_viewControllers indexOfObject:[pageViewController.viewControllers lastObject]]);
    }
}

- (void)refresh {
    [_pageViewController setDataSource:nil];
    [_pageViewController setDataSource:self];
}

@end