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
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 100, 30)];
    tf.placeholder = @"123";
    [self.view addSubview:tf];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:58/255.0f green:157/255.0f blue:255/255.0f alpha:1.0f]];
    btn.frame =  CGRectMake(30, 100, 100, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;

    [self.view addSubview:btn];
    
    RACSignal * enAbleSingal = [tf.rac_textSignal map:^id(NSString * value) {
        if (value.length > 2) {
            return @1;
        }else{
            return @0;
        }
        
    }];
    
//    [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//
//        [subscriber sendNext:@0];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//
//        }];
//    }];
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
        
//        [timeSigal subscribeCompleted:^{
//            btn.enabled = YES;
//            [btn setBackgroundColor:[UIColor colorWithRed:58/255.0f green:157/255.0f blue:255/255.0f alpha:1.0f]];
//            [saveSubscriber sendNext:@"按钮"];
//            [saveSubscriber sendCompleted];
//            NSLog(@"timer singal complte");
//        }];
    
        [btn rac_liftSelector:@selector(setTitle:forState:)
                  withSignals:[RACSignal merge:@[timeSigal,resetStringSignal]],
         [RACSignal return:@(UIControlStateNormal)], nil];
        return timeSigal;
    };
    

    btn.rac_command =  [[RACCommand alloc] initWithEnabled:enAbleSingal signalBlock:^RACSignal *(id input) {
                NSLog(@"input = %@",input);
                return CountBlock(btn);
            }];
    
//    [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton * input) {
//        return CountBlock(input);
//    }];
    
//
    /**
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        TestViewController * tvc = [TestViewController new];
        tvc.subject = [RACSubject subject];
        [tvc.subject subscribeNext:^(id x) {
            NSLog(@"下个页面按钮点击了");
            
            // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
            NSDictionary *dict = @{@"name":@"xmg",@"age":@18,@"height":@"175"};
            [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
                
                // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
                RACTupleUnpack(NSString *key,NSString *value) = x;
                
                // 相当于以下写法
//                        NSString *key = x[0];
//                        NSString *value = x[1];
                
                NSLog(@"key= %@ value = %@",key,value);
                
            }];
        }];
        [self.navigationController pushViewController:tvc animated:YES];
     
    
    }];
 */
}
@end
