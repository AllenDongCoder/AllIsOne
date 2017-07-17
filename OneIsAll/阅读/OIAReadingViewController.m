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

    UIButton * btn =[ UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(30, 100, 100, 30);
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
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
