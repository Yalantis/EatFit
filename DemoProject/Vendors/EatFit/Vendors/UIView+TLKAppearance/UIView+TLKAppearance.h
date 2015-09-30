/**
 * Created with JetBrains AppCode.
 * Author: dmitriy
 * Date: 22.04.13 16:38
 */

@import UIKit;

typedef NS_OPTIONS(NSInteger , TLKAppearanceOptions)
{
    TLKAppearanceOptionOverlay = 1 << 0,
	TLKAppearanceOptionUseAutoresize = 2 << 0,
};

@interface UIView (TLKAppearance)

- (void)tlk_addSubview:(UIView *)subview options:(TLKAppearanceOptions)options;

- (void)tlk_insertSubview:(UIView *)subview atIndex:(NSInteger)index options:(TLKAppearanceOptions)options;

@end