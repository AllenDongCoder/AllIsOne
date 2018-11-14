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
    
    
    UIButton * btn =[ UIButton buttonWithType:UIButtonTypeCustom];
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
   
    RACSignal * countSinal = [[[[RACSignal interval:1
                                        onScheduler:[RACScheduler mainThreadScheduler]]
                                startWith:[NSDate date]]
                               scanWithStart:@(60) reduce:^id(NSNumber *running, id next) {
                                   return @(running.integerValue - 1);
                               }] takeUntilBlock:^BOOL(NSNumber *x) {
                                   return x.integerValue < 0;
                               }];
    RACSignal * (^ CountBlock)(UIButton *) = ^RACSignal *(UIButton * btn){
        
        return countSinal;
    };
    

    btn.rac_command = [[RACCommand alloc] initWithEnabled:enAbleSingal signalBlock:^RACSignal *(id input) {
        NSLog(@"input = %@",input);
        return CountBlock(btn);
        //        [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //            NSLog(@"do something ");
        //            [subscriber sendNext:@"something"];
        //            [subscriber sendCompleted];
        //            return  [RACDisposable disposableWithBlock:^{
        //
        //            }];
        //        }];
    }];
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
