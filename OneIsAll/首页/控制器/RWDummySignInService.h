//
//  RWDummySignInService.h
//  OneIsAll
//
//  Created by dk on 2017/3/8.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RWSignInResponse) (BOOL);
@interface RWDummySignInService : NSObject
- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(RWSignInResponse)completeBlock;
@end
