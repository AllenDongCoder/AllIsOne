//
//  NSObject+Caculator.m
//  OneIsAll
//
//  Created by dk on 2017/3/9.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)
+ (int)makeCaculators:(myBlock)block{
    CaculatorMaker * manager =[CaculatorMaker new];
    block(manager);
    return manager.result;
}
@end
