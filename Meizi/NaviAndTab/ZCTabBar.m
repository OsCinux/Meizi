//
//  ZCTabBar.m
//  Meizi
//
//  Created by 朱立焜 on 16/1/6.
//  Copyright © 2016年 朱立焜. All rights reserved.
//

#import "ZCTabBar.h"
#import "ZCMoreDefines.h"
#import "ZCCategoryViewController.h"
#import "ZCSettingViewController.h"
#import "ZCMainCollectionViewController.h"
#import "ZCLoginViewController.h"

@interface ZCTabBar ()

@end

@implementation ZCTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customTabbar];
    [self setupAllSubViewControllers];
}

#pragma mark - 定制TabBar

- (void)customTabbar {
    
    self.tabBarController.tabBar.hidden = YES;
    // 设置不透明
    self.tabBar.translucent = NO;
    
    // 镂空颜色
//    self.tabBar.tintColor = RGBA(244, 59, 51, 1);
    self.tabBar.tintColor = krgba(0.95, 0.92, 0.5, 1);
    
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllSubViewControllers {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat sizeCompare = 236.f/354.f;
    
    CGFloat sizeWidth = ScreenWidth / 2 - 15;
    CGFloat sizeHeight = sizeWidth / sizeCompare;
    
    flowLayout.itemSize = CGSizeMake(sizeWidth, sizeHeight + 30);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self setupSingleViewController:[[ZCMainCollectionViewController alloc] initWithCollectionViewLayout:flowLayout] vcTitle:@"妹子" tabBarTitle:@"妹子" image:@"" selectedImage:@""];
    
    [self setupSingleViewController:[[ZCCategoryViewController alloc] init] vcTitle:@"专题" tabBarTitle:@"专题" image:@"" selectedImage:@""];
    
    ZCSettingViewController *setting = [[UIStoryboard storyboardWithName:@"ZCSettingViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"ZCSettingViewController"];
    [self setupSingleViewController:setting vcTitle:@"我的" tabBarTitle:@"我的" image:@"" selectedImage:@""];
    
}

/**
 *  在tabBar上加上一个子视图
 *
 *  @param viewController 子视图
 *  @param vcTitle        子视图的标题
 *  @param tabBarTitle    barItem的标题
 *  @param image          barItem的图片名
 *  @param selectedImage  barItem的选中状态图片名
 */
- (void)setupSingleViewController:(UIViewController *)viewController vcTitle:(NSString *)vcTitle tabBarTitle:(NSString *)tabBarTitle image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabBarTitle image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    [self addChildViewController:viewController title:vcTitle];
    
}

/**
 *  添加一个带导航的子视图
 *
 *  @param childController 子视图
 *  @param title           子视图的标题
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title {
    
    childController.title = title;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:childController];
    [navi.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.92 blue:0.5 alpha:1]];
    
    [self addChildViewController:navi];
    
}

@end
