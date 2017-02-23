//
//  OIAConfigBaseNavigationController.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "OIAConfigBaseNavigationController.h"
#import "UIBarButtonItem+HTBarButtonCustom.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface OIAConfigBaseNavigationController ()

@end

@implementation OIAConfigBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNavigationBarAppearance];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = CGRectGetWidth([UIScreen mainScreen].bounds)/3;
        [self setUpCustomNavigationBarWithViewController:viewController];
    }
    [super pushViewController:viewController  animated:YES];
}
#pragma mark - 设置全局的导航栏属性
- (void)setUpNavigationBarAppearance
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = @{NSFontAttributeName:HTSetFont(@"PingFang SC", 18),
                                     NSForegroundColorAttributeName: SetColor(143, 143, 143)
                                     };
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.barTintColor = SetColor(256, 256, 256);//SetColor(80, 189, 203)
}

- (void)setUpCustomNavigationBarWithViewController:(UIViewController *)viewController
{
    UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"back_default"  selectImage:@"back_default"];
    viewController.navigationItem.leftBarButtonItem = item;
}
- (void)btnLeftBtn
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - UIStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
