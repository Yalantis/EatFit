/**
 * Created with JetBrains AppCode.
 * Author: dmitriy
 * Date: 22.04.13 16:38
 */

#import "UIView+TLKAppearance.h"

typedef UIView *(^TLKSubviewTreeModifier)();

@implementation UIView (TLKAppearance)

- (void)tlk_addSubviewUsingOptions:(TLKAppearanceOptions)options modifier:(TLKSubviewTreeModifier)modifier {
    UIView *subview = modifier();
    if (!subview) return;
    
    if ((options & TLKAppearanceOptionOverlay) == TLKAppearanceOptionOverlay) {
        if ((options & TLKAppearanceOptionUseAutoresize) != TLKAppearanceOptionUseAutoresize) {
            [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            NSDictionary *views = NSDictionaryOfVariableBindings(subview);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[subview]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:views]];
        } else {
            [subview setFrame:self.bounds];
            [subview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        }
    }
}

- (void)tlk_addSubview:(UIView *)subview options:(TLKAppearanceOptions)options {
    if (subview.superview == self) return;
    
    [self tlk_addSubviewUsingOptions:options modifier:^{
        [self addSubview:subview];
        return subview;
    }];
}

- (void)tlk_insertSubview:(UIView *)subview atIndex:(NSInteger)index options:(TLKAppearanceOptions)options {
    if (subview.superview == self) return;
    
    [self tlk_addSubviewUsingOptions:options modifier:^{
        [self insertSubview:subview atIndex:index];
        return subview;
    }];
}

@end