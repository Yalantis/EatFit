//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#define ac_safeBlockCall(block, ...) block ? block(__VA_ARGS__) : nil

@import UIKit;

typedef void (^ACPageControllerTransitionHook)(UIPageViewController *pageViewController, UIViewController *viewController, NSUInteger pageIndex);

@interface ACPageController : NSObject <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, copy) ACPageControllerTransitionHook didFinishTransition;
@property (nonatomic, getter = isPagingEnabled) BOOL pagingEnabled;

- (void)showPage:(NSUInteger)index animated:(BOOL)animated;
- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end