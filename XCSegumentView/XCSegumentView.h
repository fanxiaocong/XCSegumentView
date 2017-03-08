//
//  XCSegumentView.h
//  自定义账号输入框
//
//  Created by 樊小聪 on 2016/12/2.
//  Copyright © 2016年 樊小聪. All rights reserved.
//



/*
 *  备注：自定义分段视图, 此处 每个 item 的选中状态是由内部确定, 即 点中某个 item 之后, 该 item 就为 选中状态, 外部调用者无法修改!!! 🐾
 */



#import <UIKit/UIKit.h>



/*
 *  备注：配置 🐾
 */
@interface XCSegumentOptionConfiguration : NSObject

/** 👀 文字的大小 👀 */
@property (assign, nonatomic) CGFloat titleFontSize;
/** 👀 每个 item 的宽度 👀 */
@property (assign, nonatomic) CGFloat itemWidth;
/** 👀 每个 item 的高度 👀 */
@property (assign, nonatomic) CGFloat itemHeight;
/** 👀 圆角半径 👀 */
@property (assign, nonatomic) CGFloat cornerRadius;
/** 👀 普通状态下文字的颜色 👀 */
@property (strong, nonatomic) UIColor *normalTitleColor;
/** 👀 选中状态下的文字颜色 👀 */
@property (strong, nonatomic) UIColor *selectedTitleColor;
/** 👀 普通状态下的背景颜色 👀 */
@property (strong, nonatomic) UIColor *normalBackgroundColor;
/** 👀 选中状态下的背景颜色 👀 */
@property (strong, nonatomic) UIColor *selectedBackgroundColor;

/**
 默认配置
 */
+ (instancetype)defaultConfiguration;

@end


/* 🐖 ***************************** 🐖 XCSegumentView 🐖 *****************************  🐖 */


@interface XCSegumentView : UIView

/**
 返回一个自定义分段视图：       默认选中第 0 个 item
 
 @param titles              标题数组
 @param options             配置参数    传空为 默认配置
 @param didClickItemHandle  点击的回调
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                       options:(XCSegumentOptionConfiguration *)options
            didClickItemHandle:(void(^)(XCSegumentView *segumentView, NSInteger index))didClickItemHandle;



/**
 返回一个自定义分段视图

 @param titles              标题数组
 @param defaulstIndex       默认选中的下标
 @param options             配置参数     传空为 默认配置
 @param didClickItemHandle  点击的回调
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
          defaultSelectedIndex:(NSInteger)defaulstIndex
                       options:(XCSegumentOptionConfiguration *)options
            didClickItemHandle:(void (^)(XCSegumentView *, NSInteger))didClickItemHandle;


/**
 返回一个自定义分段视图

 @param titles              标题数组
 @param options             配置参数
 @param didClickItemHandle  点击的回调
 */
+ (instancetype)segumentViewWithTitles:(NSArray<NSString *> *)titles
                               options:(XCSegumentOptionConfiguration *)options
                    didClickItemHandle:(void(^)(XCSegumentView *segumentView, NSInteger index))didClickItemHandle;


/**
 返回一个自定义分段视图
 
 @param titles              标题数组
 @param defaulstIndex       默认选中的下标
 @param options             配置参数     传空为 默认配置
 @param didClickItemHandle  点击的回调
 */
+ (instancetype)segumentViewWithTitles:(NSArray<NSString *> *)titles
                  defaultSelectedIndex:(NSInteger)defaulstIndex
                               options:(XCSegumentOptionConfiguration *)options
                    didClickItemHandle:(void (^)(XCSegumentView *, NSInteger))didClickItemHandle;


/**
 显示 item 上的小红点

 @param index 要显示小红点的下标
 */
- (void)showRedDotAtIndex:(NSInteger)index;

/**
 显示多个 item 上的小红点

 @param indexs 要显示小红点的下标数组
 */
- (void)showRedDotsAtIndexs:(NSArray<NSNumber *> *)indexs;


/**
 隐藏 item 上的小红点
 
 @param index 要隐藏小红点的下标
 */
- (void)hideRedDotAtIndex:(NSInteger)index;

/**
 隐藏所有小红点
 */
- (void)hideAllRedDots;

@end



































