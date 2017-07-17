//
//  RWDummySignInService.m
//  OneIsAll
//
//  Created by dk on 2017/3/8.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "RWDummySignInService.h"

@implementation RWDummySignInService
-(void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock{
    if (username.length>0&&password.length>0) {
        completeBlock(YES);
    }else{
        completeBlock(NO);

    }
    
}
@end
