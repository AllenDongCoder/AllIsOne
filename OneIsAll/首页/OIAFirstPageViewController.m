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
#import "HTNetWorking.h"
#import "FirstPageCellOne.h"


#import "RWDummySignInService.h"
#import "NSObject+Caculator.h"
@interface OIAFirstPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray * dataArr;
@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UITextField * tf;
@property(nonatomic,strong) UITextField * tf2;

@property(nonatomic,strong) RWDummySignInService * signInService;
@end

@implementation OIAFirstPageViewController
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一个";
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 200, 60)];
    tf.placeholder = @"请输入";
    self.tf = tf;
    [self.view addSubview:tf];
    
    UITextField * tf2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, 200, 90)];
    tf2.placeholder = @"密码";
    self.tf2 = tf2;
    [self.view addSubview:tf2];
    
    
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 300, 60, 30);
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    
    UILabel * alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.centerX,self.view.centerY, 100, 30)];
    alertLabel.text = @"登录失败";
    alertLabel.hidden = YES;
    alertLabel.backgroundColor = [UIColor brownColor];
    [self.view addSubview:alertLabel];
    

    
    RAC(tf,backgroundColor) = [tf.rac_textSignal map:^id(id value) {
        return [(NSString *)value length] > 3?[UIColor grayColor]:[UIColor yellowColor];
    }];
    
    
//    [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
//        return [self signInSignal];
//    }] subscribeNext:^(id x) {
//        NSLog(@"sign in result :%@",x);
//    }];
    
    [[[[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
    doNext:^(id x) {
        [(UIButton *)x setEnabled:NO];
        alertLabel.hidden = YES;
    
    }]
      
      flattenMap:^RACStream *(id value) {
          NSLog(@"value - =: %@",value);
        return [self signInSignal];
    }]
    subscribeNext:^(id x) {
        btn.enabled = YES;
        BOOL su = [(NSNumber *)x boolValue];
        alertLabel.hidden = su;
        if (su) {
            NSLog(@"跳转");
        }
        NSLog(@"sign in result :%@",x);
        [self.view endEditing:YES];
    }];
    
    int result = [NSObject makeCaculators:^void(CaculatorMaker * make) {
       CaculatorMaker * maker =  make.add(2);
        NSLog(@"maker.result= %d",maker.result);
//        make.add(10).divide(2);
    }];
    NSLog(@"result = %d",result);
    //    [self initView];
    [self request];
    
  
}

- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
        [self.signInService
                             signInWithUsername:self.tf.text
                            password:self.tf2.text
                            complete:^(BOOL success){
                                
                                
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}
- (RWDummySignInService *)signInService{
    if (!_signInService) {
        _signInService = [RWDummySignInService new];
    }
    return _signInService;
}
- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    [self.tableView registerClass:[FirstPageCellOne class] forCellReuseIdentifier:@"FirstPageOne"];
    [self.view addSubview:self.tableView];
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
   
    
    //CityTravel_URL
    //http://v3.wufazhuce.com:8000/api/onelist/idlist?platform=ios&uuid=BE06D7CB-2EA0-46DF-BC0A-1E28DAB917FD&user_id=&version=v4.0.8
    BOOL isHasChines = [commonTool isIncludeChinese:@"jljlj"];
    BOOL isChines =[commonTool isIncludeChinese:@"ljglj中ggg"];
    NSLog(@"中文:%d - Chinese: %d",isHasChines,isChines);
    
    NSDictionary *params = @{@"user_id":@"",@"version":@"v4.0.8",@"platform":@"ios",@"uuid":@"uuid=BE06D7CB-2EA0-46DF-BC0A-1E28DAB917FD"};
    
    [BNHttp(@"GET").url(CityTravel_URL).params(params) data:^(id data) {
    
        
        NSArray * arr = data[@"data"][@"content_list"];
        
        for (NSDictionary * dic in arr) {
            ModelOne * model =[ModelOne new];
            [ModelOne mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         
                         
                         };
            }];
            [model mj_setKeyValues:dic];
            [self.dataArr addObject:model];
        }
        NSLog(@"%@",data[@"content_list"][@"author"]);
    
        
    } failure:^{
        
    } always:^{
    
    }];
    

    
    
    

}
#pragma mark -tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  FirstPageCellOne * pageCell =   [tableView dequeueReusableCellWithIdentifier:@"FirstPageOne" forIndexPath:indexPath];
    
    return pageCell;
    
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
