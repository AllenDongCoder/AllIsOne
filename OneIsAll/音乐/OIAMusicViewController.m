//
//  OIAMusicViewController.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "OIAMusicViewController.h"

@interface OIAMusicViewController ()
@property(nonatomic,strong) RACDisposable * ssdispos  ;
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
    __block int a = 10;
 self.ssdispos = [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] startWith:@"start"] map:^id(id value) {
      a = a-  1;
      return @(a);
    }] takeUntilBlock:^BOOL(id x) {
        return x <= 0;
    }]   subscribeNext:^(id x) {
        NSLog(@"schele = %@",x );
        if ([x integerValue] < 0 ) {
            [self.ssdispos dispose];
        }
        
    }];
    
    
//    RACSignal * countsingal =  [[[[RACSignal interval:1
//                                          onScheduler:[RACScheduler mainThreadScheduler]]
//                                  startWith:[NSDate date]]
//                                 scanWithStart:@(10) reduce:^id(NSNumber *running, id next) {
//                                     NSLog(@"running = %@",running);
//                                     return @(running.integerValue - 1);
//                                 }] takeUntilBlock:^BOOL(NSNumber *x) {
//                                     return x.integerValue < 0;
//                                 }];
//    [countsingal subscribeNext:^(id x) {
//        NSLog(@"222");
//    }];

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
