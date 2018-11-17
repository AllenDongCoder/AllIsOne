//
//  OIAReadingViewController.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "OIAReadingViewController.h"
#import "TestViewController.h"
@interface OIAReadingViewController ()

@end

@implementation OIAReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =@"一个阅读";
   [[[RACSignal return:@(10)] scanWithStart:@(20) reduceWithIndex:^id(id running, id next, NSUInteger index) {
        NSLog(@"running = %@ - next = %@ index = %ld",running ,next,index);
       return running;
    }]  subscribeNext:^(id x) {
       
        NSLog(@"x = = %@",x);
    }];
    [[[RACSignal return:@[@(10),@(11),@(12),@(13),@(14),@(15)]] scanWithStart:@(1) reduce:^id(id running, NSArray * next) {
        NSLog(@"running = %@ - next = %@ index ",running ,next);
        return @([running integerValue] - [next.lastObject integerValue]);
    }] subscribeNext:^(id x) {
        NSLog(@"x = = %@",x);
    }];
    
    [self testOne];
}

-(void)testOne{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:58/255.0f green:157/255.0f blue:255/255.0f alpha:1.0f]];
    btn.frame =  CGRectMake(30, 100, 100, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
    RACSignal * (^countBlock)(UIButton *) = ^RACSignal *(UIButton * btn){
        RACSignal * countsingal =  [[[[RACSignal interval:1
                                              onScheduler:[RACScheduler mainThreadScheduler]]
                                      startWith:[NSDate date]]
                                     scanWithStart:@(10) reduce:^id(NSNumber *running, id next) {
                                         NSLog(@"running = %@",running);
                                         return @(running.integerValue - 1);
                                     }] takeUntilBlock:^BOOL(NSNumber *x) {
                                         return x.integerValue < 0;
                                     }];
        return countsingal;
    };
    
    
    
    RACSignal * (^CountBlock)(UIButton *) = ^RACSignal *(UIButton * btn){
        RACSignal * timeSigal =  [countBlock(btn) map:^id(NSNumber * value) {
            return [NSString  stringWithFormat:@"剩余%@",value];
        }];
        btn.enabled = NO;
        [btn setBackgroundColor:[UIColor grayColor]];
        __block id<RACSubscriber> saveSubscriber = nil;
        RACSignal *resetStringSignal =
        [RACSignal createSignal:^RACDisposable *(id<RACSubscriber>  subscriber) {
            saveSubscriber = subscriber;
            return nil;
        }];
        
        [timeSigal subscribeCompleted:^{
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor colorWithRed:58/255.0f green:157/255.0f blue:255/255.0f alpha:1.0f]];
            [saveSubscriber sendNext:@"按钮"];
            [saveSubscriber sendCompleted];
            NSLog(@"timer singal complte");
        }];
        
        [btn rac_liftSelector:@selector(setTitle:forState:)
                  withSignals:[RACSignal merge:@[timeSigal,resetStringSignal]],
         [RACSignal return:@(UIControlStateNormal)], nil];
        return timeSigal;
    };
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return CountBlock(btn);
    }];

}
@end
