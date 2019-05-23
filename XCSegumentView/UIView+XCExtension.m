//
//  UIView+XCExtension.m
//  常用分类
//
//  Created by 樊小聪 on 2017/2/24.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "UIView+XCExtension.h"
#import <objc/runtime.h>

@implementation UIView (XCExtension)

/* 🐖 ***************************** 🐖 华丽的分隔线 🐖 *****************************  🐖 */

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/* 🐖 ***************************** 🐖 华丽的分隔线 🐖 *****************************  🐖 */


- (void)setTapGestureHandle:(void (^)(UITapGestureRecognizer *, UIView *))tapGestureHandle
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHandle:)];
    
    [self addGestureRecognizer:tapGesture];
    
    objc_setAssociatedObject(self, @selector(tapGestureHandle), tapGestureHandle, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITapGestureRecognizer *, UIView *))tapGestureHandle
{
    return objc_getAssociatedObject(self, _cmd);
}




- (void)didTapHandle:(UITapGestureRecognizer *)tap
{
    void (^tapGestureHandle)(UITapGestureRecognizer *tap, UIView *tapView) = objc_getAssociatedObject(self, @selector(tapGestureHandle));
    
    if (tapGestureHandle)
    {
        tapGestureHandle(tap, tap.view);
    }
}


@end
