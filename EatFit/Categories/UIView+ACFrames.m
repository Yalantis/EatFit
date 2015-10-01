//
// Created by Aleksey on 15.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "UIView+ACFrames.h"

@implementation UIView (ACFrames)

- (CGFloat)ac_x {
    return self.frame.origin.x;
}

- (CGFloat)ac_y {
    return self.frame.origin.y;
}

- (CGFloat)ac_width {
    return self.frame.size.width;
}

- (CGFloat)ac_height {
    return self.frame.size.height;
}


- (CGFloat)ac_rightEdge {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)ac_bottomEdge {
    return self.frame.origin.y + self.frame.size.height;
}

- (instancetype)ac_setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    [self setFrame:frame];

    return self;
}


- (instancetype)ac_placeBottomAt:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - self.frame.size.height;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_placeRightAt:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.y = rightX - self.frame.size.width;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_moveX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x += x;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_moveY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y += y;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_trimTop:(CGFloat)topOffset {
    CGRect frame = self.frame;
    frame.origin.y += topOffset;
    frame.size.height -= topOffset;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_trimBottom:(CGFloat)bottomOffset {
    CGRect frame = self.frame;
    frame.size.height -= bottomOffset;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_trimLeft:(CGFloat)leftOffset {
    CGRect frame = self.frame;
    frame.origin.x += leftOffset;
    frame.size.width -= leftOffset;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_trimRight:(CGFloat)rightOffset {
    CGRect frame = self.frame;
    frame.size.width -= rightOffset;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_moveToCenterOf:(UIView *)view {
    CGRect frame = self.frame;
    CGPoint center = view.center;
    frame.origin.x = center.x - [self ac_width] / 2;
    frame.origin.y = center.y - [self ac_height] / 2;
    [self setFrame:frame];

    return self;
}

- (instancetype)ac_moveBottomEdgeTo:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.size.height = bottomY - frame.origin.y;
    [self setFrame:frame];

    return self;}

- (instancetype)ac_moveRightEdgeTo:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.size.width = rightX - frame.origin.x;
    [self setFrame:frame];

    return self;
}

@end