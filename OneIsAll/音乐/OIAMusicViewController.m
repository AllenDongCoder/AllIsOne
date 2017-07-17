//
//  OIAMusicViewController.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "OIAMusicViewController.h"

@interface OIAMusicViewController ()

@end

@implementation OIAMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一个音乐";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"bundle"];
    NSBundle * bundle =[NSBundle bundleWithPath:path];
    UINib * nib = [UINib nibWithNibName:@"TestView" bundle:bundle];
    NSArray * arr = [nib instantiateWithOwner:nil options:nil];
    UIView * view = [arr lastObject];
    view.frame = CGRectMake(10, 30, 100, 100);
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
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
