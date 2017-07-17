//
//  TestViewController.m
//  OneIsAll
//
//  Created by dk on 2017/3/14.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TEST";
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark - TestOne
    
    RACSignal * singel =[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"发送请求...");
        [subscriber sendNext:@"2"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    
    }];
   RACMulticastConnection * connect =  [singel publish];
    
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅1");
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅2");
    }];
    
    [connect connect];
#pragma mark -TestTwo
    
    // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];

    
#pragma mark --TestThree
    [[self.view rac_valuesForKeyPath:@"backgroundColor" observer:self] subscribeNext:^(id x) {
        
        
    }];
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        NSLog(@"执行命令");
        
        // 创建空信号,必须返回信号
        //        return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];

    
    
    UIButton * btn =[ UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(30, 100, 100, 30);
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         
         if (self.subject) {
//             [self.subject sendNext:nil];
         }
         
         
         
//         [command.executionSignals subscribeNext:^(id x) {
//            
//             NSLog(@"x = %@",x);
//         }];
         
         [command.executionSignals.switchToLatest subscribeNext:^(id x) {
             
             NSLog(@"ex = %@",x);
         }];
         
         [[command.executing skip:1] subscribeNext:^(id x) {
             
             if ([x boolValue] == YES) {
                 // 正在执行
                 NSLog(@"正在执行");
                 
             }else{
                 // 执行完成
                 NSLog(@"执行完成");
             }
             
         }];
         
         [command execute:@1];
     }];

    
    // Do any additional setup after loading the view.
}
- (void)updateUIWithR1:(id)data r2:(id)data1{
    NSLog(@"更新UI%@----%@",data,data1);
    
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
