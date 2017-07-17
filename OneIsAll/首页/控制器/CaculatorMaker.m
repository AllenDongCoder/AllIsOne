//
//  CaculatorMaker.m
//  OneIsAll
//
//  Created by dk on 2017/3/9.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker
- (CaculatorMaker *(^)(int))add{

    makeBlock block =^CaculatorMaker*(int value){
        NSLog(@"value = %d",value);
        _result +=value;
        return self;
    };
    return block;
}
-(CaculatorMaker *(^)(int))sub{
    return ^CaculatorMaker*(int value){
        _result-=value;
        return self;
    };
}
- (CaculatorMaker *(^)(int))muilt{
    return ^CaculatorMaker*(int value){
        _result= _result * value;
        return self;
    };
 
}
-(CaculatorMaker *(^)(int))divide{
    
    return ^CaculatorMaker*(int value){
        _result= _result/value;
        return self;
    };

}
@end
