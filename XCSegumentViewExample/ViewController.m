//
//  ViewController.m
//  XCSegumentViewExample
//
//  Created by 樊小聪 on 2017/3/8.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import "XCSegumentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置 UI
    [self setupUI];
}

- (void)setupUI
{
    // 设置 titleView
    XCSegumentView *titleView = [XCSegumentView segumentViewWithTitles:@[@"消息", @"好友", @"群组"] options:NULL didClickItemHandle:^(XCSegumentView *segumentView, NSInteger index) {
        
        NSLog(@"点击了第%zi个按钮", index);

    }];
    
    self.navigationItem.titleView = titleView;
}

@end
