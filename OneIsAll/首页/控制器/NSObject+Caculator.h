//
//  NSObject+Caculator.h
//  OneIsAll
//
//  Created by dk on 2017/3/9.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"
typedef void(^myBlock) (CaculatorMaker *);
@interface NSObject (Caculator)
+ (int )makeCaculators:(myBlock) block;
@end
