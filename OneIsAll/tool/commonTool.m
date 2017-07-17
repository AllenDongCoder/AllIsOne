
//
//  commonTool.m
//  OneIsAll
//
//  Created by dk on 2017/3/3.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "commonTool.h"

@implementation commonTool
+(BOOL)isIncludeChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
}
@end
