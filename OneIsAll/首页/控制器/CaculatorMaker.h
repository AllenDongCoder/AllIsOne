//
//  CaculatorMaker.h
//  OneIsAll
//
//  Created by dk on 2017/3/9.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaculatorMaker;
typedef CaculatorMaker * (^makeBlock)(int);
@interface CaculatorMaker : NSObject
@property(nonatomic,assign) int result ;
- (CaculatorMaker *(^)(int))add;
- (CaculatorMaker *(^)(int))sub;
- (CaculatorMaker *(^)(int))muilt;
- (CaculatorMaker *(^)(int))divide;
@end
