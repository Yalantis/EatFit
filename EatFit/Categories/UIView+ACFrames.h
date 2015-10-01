//
// Created by Aleksey on 15.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACFrames)

//GETTERS

- (CGFloat)ac_x;
- (CGFloat)ac_y;
- (CGFloat)ac_width;
- (CGFloat)ac_height;
- (CGFloat)ac_rightEdge;
- (CGFloat)ac_bottomEdge;

//MOVE

//absolute
- (instancetype)ac_setX:(CGFloat)x;
- (instancetype)ac_setY:(CGFloat)y;

- (instancetype)ac_setOrigin:(CGPoint)origin;

- (instancetype)ac_placeBottomAt:(CGFloat)bottomY;
- (instancetype)ac_placeRightAt:(CGFloat)rightX;

//offset
- (instancetype)ac_moveX:(CGFloat)xOffset;
- (instancetype)ac_moveY:(CGFloat)yOffset;

//CHANGE DIMENSIONS

//absolute
- (instancetype)ac_setWidth:(CGFloat)width;
- (instancetype)ac_setHeight:(CGFloat)height;

- (instancetype)ac_moveBottomEdgeTo:(CGFloat)bottomY;
- (instancetype)ac_moveRightEdgeTo:(CGFloat)rightX;

//relative
- (instancetype)ac_trimTop:(CGFloat)topOffset;
- (instancetype)ac_trimBottom:(CGFloat)bottomOffset;
- (instancetype)ac_trimLeft:(CGFloat)leftOffset;
- (instancetype)ac_trimRight:(CGFloat)rightOffset;

- (instancetype)ac_moveToCenterOf:(UIView *)view;


@end