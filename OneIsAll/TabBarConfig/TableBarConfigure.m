//
//  TableBarConfigure.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "TableBarConfigure.h"
#import "HTCustomTabBarController.h"
#import "OIAMovieViewController.h"
#import "OIAMusicViewController.h"
#import "OIAReadingViewController.h"
#import "OIAFirstPageViewController.h"
@interface TableBarConfigure()

@end
@implementation TableBarConfigure
/**
 *  懒加载tabBarController
 *
 */
- (HTCustomTabBarController *)tabBarController
{
    return HT_LAZY(_tabBarController, ({
        HTCustomTabBarController *tabBarController = [HTCustomTabBarController tabBarControllerWithViewControllers:self.viewControllersForController tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        
        // tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [self customizeTabBarAppearance:tabBarController];
        tabBarController;
    }));
}

- (NSArray *)viewControllersForController {
    
    // 数据服务
//    self.viewModelService = [[HTViewModelServicesImpl alloc] initModelServiceImpl];
    
    // 首页
//    self.cityTravelViewModel = [[HTCityTravelViewModel alloc] initWithServices:self.viewModelService];
    OIAFirstPageViewController *firstViewController = [OIAFirstPageViewController new];
    OIAConfigBaseNavigationController *firstNavigationController = [[OIAConfigBaseNavigationController alloc]
                                                                   initWithRootViewController:firstViewController];
    
    // 阅读
//    self.findViewModel = [[HTFindViewModel alloc] initWithServices:self.viewModelService];
    OIAReadingViewController * readingViewController = [OIAReadingViewController new] ;    OIAConfigBaseNavigationController *secondNavigationController = [[OIAConfigBaseNavigationController alloc]
                                                                    initWithRootViewController:readingViewController];
    
    // 音乐
    OIAMusicViewController  * musicViewController = [[OIAMusicViewController  alloc] init];
    OIAConfigBaseNavigationController *thirdNavigationController = [[OIAConfigBaseNavigationController alloc]
                                                                   initWithRootViewController:musicViewController];
    
    // 影视
    OIAMovieViewController * meViewController = [[OIAMovieViewController alloc] init];
    OIAConfigBaseNavigationController *fourNavigationController = [[OIAConfigBaseNavigationController alloc]
                                                                  initWithRootViewController:meViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourNavigationController
                                 ];
    return viewControllers;
}


/**
 *  设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (NSArray *)tabBarItemsAttributesForController{
    
    NSDictionary *dict1 = @{
                            HTTabBarItemTitle : @"首页",
                            HTTabBarItemImage : @"homeUnselectedV4",
                            HTTabBarItemSelectedImage : @"homeSelectedV4",
                            };
    NSDictionary *dict2 = @{
                            HTTabBarItemTitle : @"阅读",
                            HTTabBarItemImage : @"readUnselectedV4",
                            HTTabBarItemSelectedImage : @"readSelectedV4@2x",
                            };
    NSDictionary *dict3 = @{
                            HTTabBarItemTitle : @"音乐",
                            HTTabBarItemImage : @"musicUnselectedV4",
                            HTTabBarItemSelectedImage : @"musicSelectedV4",
                            };
    NSDictionary *dict4 = @{
                            HTTabBarItemTitle : @"影视",
                            HTTabBarItemImage : @"movieUnselectedV4",
                            HTTabBarItemSelectedImage : @"movieSelectedV4",
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性的设置
 */
- (void)customizeTabBarAppearance:(HTCustomTabBarController *)tabBarController {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    
    selectedAttrs[NSForegroundColorAttributeName] = SetColor(143, 143, 143);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
}
@end
