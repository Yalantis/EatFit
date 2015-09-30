//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIPageViewController+ACPageController.h"

static void *ACPageControllerKey;

@interface UIPageViewController ()

@property (nonatomic, strong) ACPageController *ac_controller;

@end

@implementation UIPageViewController (ACPageController)

- (ACPageController *)ac_controller {
    ACPageController *controller = objc_getAssociatedObject(self, &ACPageControllerKey);
    if (controller) return controller;

    controller = [ACPageController new];
    objc_setAssociatedObject(self, &ACPageControllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:controller];
    [self setDataSource:controller];
    [controller setPageViewController:self];

    return controller;
}

- (void)ac_setViewControllers:(NSArray *)viewControllers {
    [self.ac_controller setViewControllers:[viewControllers copy]];
}

- (NSArray *)ac_viewControllers {
    return [self.ac_controller viewControllers];
}

- (void)ac_showViewController:(UIViewController *)viewController {
    [self.ac_controller showViewController:viewController animated:YES];
}

- (void)ac_showViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.ac_controller showViewController:viewController animated:animated];
}

- (void)ac_showPage:(NSInteger)page {
    [self ac_showPage:page animated:YES];
}

- (void)ac_showPage:(NSInteger)page animated:(BOOL)animated {
    [self.ac_controller showPage:(NSUInteger)page animated:animated];
}

- (void)ac_setDidFinishTransition:(ACPageControllerTransitionHook)didFinishTransition {
    [self.ac_controller setDidFinishTransition:didFinishTransition];
}

- (void)ac_setPagingEnabled:(BOOL)enabled {
    [self.ac_controller setPagingEnabled:enabled];
}

@end