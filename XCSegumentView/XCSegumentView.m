//
//  XCSegumentView.m
//  自定义账号输入框
//
//  Created by 樊小聪 on 2016/12/2.
//  Copyright © 2016年 樊小聪. All rights reserved.
//



/*
 *  备注：自定义分段视图 🐾
 */

#import "XCSegumentView.h"

#import "UIView+XCExtension.h"


#define K_DEFAULT_TAG    888



@implementation XCSegumentOptionConfiguration
+ (instancetype)defaultConfiguration
{
    XCSegumentOptionConfiguration *configurations = [[XCSegumentOptionConfiguration alloc] init];
    
    /*⏰ ----- 这里配置一些默认参数 ----- ⏰*/
    configurations.titleFontSize = 13;
    configurations.itemWidth     = 70;
    configurations.itemHeight    = 30;
    configurations.cornerRadius  = 2;
    configurations.normalTitleColor        = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
    configurations.selectedTitleColor      = [UIColor redColor];
    configurations.normalBackgroundColor   = [UIColor lightGrayColor];
    configurations.selectedBackgroundColor = [UIColor orangeColor];
    
    return configurations;
}
@end

/* 🐖 ***************************** 🐖 XCSegumentItem 🐖 *****************************  🐖 */

#pragma mark - 👀 Private XCSegumentItem 👀 💤

@interface XCSegumentItem : UIView
/** 👀 标题 LB 👀 */
@property (weak, nonatomic) UILabel *titleLB;
/** 👀 小红点 👀 */
@property (weak, nonatomic) UIView *redDotView;

/** 👀 普通状态下背景颜色 👀 */
@property (weak, nonatomic) UIColor *normalBackgroundColor;
/** 👀 选中状态下背景颜色 👀 */
@property (weak, nonatomic) UIColor *selectedBackgrondColor;
/** 👀 普通状态下文字的颜色 👀 */
@property (weak, nonatomic) UIColor *normalTitleColor;
/** 👀 选中状态下文字的颜色 👀 */
@property (weak, nonatomic) UIColor *selectedTitleColor;

/** 👀 是否显示小红点 👀 */
@property (assign, nonatomic, getter=isShowRedDot) BOOL showRedDot;
/** 👀 选中状态 👀 */
@property (assign, nonatomic, getter=isSelected) BOOL selected;
@end


@implementation XCSegumentItem
#pragma mark - 👀 Init Method 👀 💤
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置默认参数
        [self setupDefaults];
    }
    
    return self;
}

// 设置默认参数
- (void)setupDefaults
{
    /*⏰ ----- 添加 LB ----- ⏰*/
    UILabel *titleLB = [UILabel new];
    _titleLB = titleLB;
    [self addSubview:titleLB];
    
    /*⏰ ----- 添加 小红点 ----- ⏰*/
    UIView *redDot = [UIView new];
    _redDotView                 = redDot;
    _redDotView.backgroundColor = [UIColor redColor];
    _redDotView.layer.cornerRadius  = 3;
    _redDotView.layer.masksToBounds = YES;
    [self addSubview:redDot];
    
    self.showRedDot = NO;
    self.selected   = NO;
}

- (void)layoutSubviews
{
    CGSize titleSize = [self.titleLB.text sizeWithAttributes:@{NSFontAttributeName : self.titleLB.font}];
    
    self.titleLB.size = titleSize;
    self.titleLB.centerX = self.width * 0.5;
    self.titleLB.centerY = self.height * 0.5;
    
    self.redDotView.left    = CGRectGetMaxX(self.titleLB.frame);
    self.redDotView.top     = self.titleLB.top;
    self.redDotView.size = CGSizeMake(6, 6);
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setShowRedDot:(BOOL)showRedDot
{
    _showRedDot = showRedDot;
    
    self.redDotView.hidden = !showRedDot;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (selected)
    {
        self.backgroundColor   = self.selectedBackgrondColor;
        self.titleLB.textColor = self.selectedTitleColor;
    }
    else
    {
        self.backgroundColor   = self.normalBackgroundColor;
        self.titleLB.textColor = self.normalTitleColor;
    }
}

@end



/* 🐖 ***************************** 🐖 XCSegumentView 🐖 *****************************  🐖 */

@interface XCSegumentView ()

@property (strong, nonatomic) XCSegumentOptionConfiguration *options;
/** 👀 标题数组 👀 */
@property (strong, nonatomic) NSArray<NSString *> *titles;

/** 👀 选中的 item 👀 */
@property (weak, nonatomic) XCSegumentItem *selectedItem;

/** 👀 默认选中的下标 👀 */
@property (assign, nonatomic) NSInteger defaultSelectedIndex;

@property (copy, nonatomic) void(^didClickItemHandle)(XCSegumentView *segumentView, NSInteger index);

@end


@implementation XCSegumentView

#pragma mark - 🔒 👀 Privite Method 👀

/**
    设置 UI
 */
- (void)setupUI
{
    self.backgroundColor     = [UIColor clearColor];
    self.layer.cornerRadius  = self.options.cornerRadius;
    self.layer.masksToBounds = YES;
    
    NSInteger count = self.titles.count;
    
    CGFloat itemW = self.options.itemWidth;
    CGFloat itemH = self.options.itemHeight;
    CGFloat itemY = 0;
    
    CGFloat seperatorLineW = 1;
    
    CGFloat selfW = itemW * count + seperatorLineW * (count - 1);
    CGFloat selfH = itemH;
    
    self.frame = CGRectMake(0, 0, selfW, selfH);
    
    __block typeof(self)weakSelf = self;
    
    /*⏰ ----- 添加子视图 ----- ⏰*/
    for (NSInteger i = 0; i < count; i ++)
    {
        CGFloat itemX = (itemW + seperatorLineW) * i;
        
        XCSegumentItem *item = [[XCSegumentItem alloc] initWithFrame:CGRectMake(itemX, itemY, itemW, itemH)];
        
        [self addSubview:item];
        
        item.tag = K_DEFAULT_TAG + i;
        item.normalTitleColor       = self.options.normalTitleColor;
        item.selectedTitleColor     = self.options.selectedTitleColor;
        item.normalBackgroundColor  = self.options.normalBackgroundColor;
        item.selectedBackgrondColor = self.options.selectedBackgroundColor;
        item.selected = NO;
        
        item.titleLB.font = [UIFont systemFontOfSize:self.options.titleFontSize];
        item.titleLB.text = self.titles[i];
        
        item.tapGestureHandle = ^(UITapGestureRecognizer *tap, UIView *tapView){
            
            /*⏰ ----- 点击了 item 的回调 ----- ⏰*/
            [weakSelf didClickItem:(XCSegumentItem *)tapView index:i];
        };
        
        /*⏰ ----- 默认选中 ----- ⏰*/
        if (i == self.defaultSelectedIndex)
        {
            [weakSelf didClickItem:item index:i];
        }
    }
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 点击了item 的回调

 @param item    点击的 item
 @param index   下标
 */
- (void)didClickItem:(XCSegumentItem *)item index:(NSInteger)index
{
    if (self.selectedItem == item)       return;
    
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
    
    /*⏰ ----- 点击的回调 ----- ⏰*/
    if (self.didClickItemHandle)
    {
        self.didClickItemHandle(self, index);
    }
}


#pragma mark - 🔓 👀 Public Method 👀

/**
 返回一个自定义分段视图
 
 @param titles              标题数组
 @param options             配置参数
 @param didClickItemHandle  点击的回调
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                       options:(XCSegumentOptionConfiguration *)options
            didClickItemHandle:(void(^)(XCSegumentView *segumentView, NSInteger index))didClickItemHandle
{
    return [self initWithTitles:titles defaultSelectedIndex:0 options:options didClickItemHandle:didClickItemHandle];
}

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
            didClickItemHandle:(void (^)(XCSegumentView *, NSInteger))didClickItemHandle
{
    if (self = [super init])
    {
        self.options = options ? options : [XCSegumentOptionConfiguration defaultConfiguration];
        self.titles  = titles;
        self.defaultSelectedIndex = defaulstIndex;
        self.didClickItemHandle   = didClickItemHandle;
        
        /*⏰ ----- 设置 UI ----- ⏰*/
        [self setupUI];
    }
    
    return self;
}


/**
 返回一个自定义分段视图
 
 @param titles              标题数组
 @param options             配置参数
 @param didClickItemHandle  点击的回调
 */
+ (instancetype)segumentViewWithTitles:(NSArray<NSString *> *)titles
                               options:(XCSegumentOptionConfiguration *)options
                    didClickItemHandle:(void(^)(XCSegumentView *segumentView, NSInteger index))didClickItemHandle
{
    return [[self alloc] initWithTitles:titles options:options didClickItemHandle:didClickItemHandle];
}


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
                    didClickItemHandle:(void (^)(XCSegumentView *, NSInteger))didClickItemHandle
{
    return [[self alloc] initWithTitles:titles defaultSelectedIndex:defaulstIndex options:options didClickItemHandle:didClickItemHandle];
}

/**
 显示 item 上的小红点
 
 @param index 要显示小红点的下标
 */
- (void)showRedDotAtIndex:(NSInteger)index
{
    [self showRedDotsAtIndexs:@[@(index)]];
}

/**
 显示多个 item 上的小红点
 
 @param indexs 要显示小红点的下标数组
 */
- (void)showRedDotsAtIndexs:(NSArray<NSNumber *> *)indexs
{
    [indexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger index = obj.integerValue;
        
        XCSegumentItem *item = [self viewWithTag:(index + K_DEFAULT_TAG)];
        item.showRedDot = YES;
    }];
}


/**
 隐藏 item 上的小红点
 
 @param index 要隐藏小红点的下标
 */
- (void)hideRedDotAtIndex:(NSInteger)index
{
    XCSegumentItem *item = [self viewWithTag:(index + K_DEFAULT_TAG)];
    
    item.showRedDot = NO;
}

/**
 隐藏所有小红点
 */
- (void)hideAllRedDots
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isMemberOfClass:[XCSegumentItem class]])
        {
            XCSegumentItem *item = (XCSegumentItem *)obj;
            item.showRedDot = NO;
        }
    }];
}

@end

