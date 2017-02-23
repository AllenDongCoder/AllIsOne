//
//  OIAFirstPageViewController.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "OIAFirstPageViewController.h"
#import "OIADetailViewController.h"
#import "BNHttpClient.h"
@interface OIAFirstPageViewController ()

@end

@implementation OIAFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一个";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 100, 100, 50);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self request];
    
   
    // Do any additional setup after loading the view.
}
- (void)btnClick:(UIButton *)btn{
    OIADetailViewController *detailVC = [OIADetailViewController new];
    detailVC.title =@"详情";
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)request{

    
    
//    [BNHttp(@"GET")
//     .url(@"http://www.xsdota.com").param(nil)
//     .addHttpHeader(@"cache-control",@"max-age=100")
//     .addAcceptFormat(@"text/html")
//     data:^(id data) {
//         NSLog(@"success");
//     } failure:^{
//         NSLog(@"failure");
//     } always:^{
//         NSLog(@"always");
//     }];
    
    
    [BNHttp(@"GET").url(CityTravel_URL).params(nil) data:^(id data) {
        NSLog(@"data = %@",data);
        
        
    } failure:^{
        
    } always:^{
    
    }];
    
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
