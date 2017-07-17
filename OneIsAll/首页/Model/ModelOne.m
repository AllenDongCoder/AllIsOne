

//
//  ModelOne.m
//  OneIsAll
//
//  Created by dk on 2017/3/3.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "ModelOne.h"

@implementation ModelOne
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"dateStr":@"date",
             @"picUrlStr":@"img_url",
             @"titleStr":@"title",
             @"forwardStr":@"forward",
             @"autherStr":@"words_info",
             @"fansNumStr":@"like_count",
             @"isLikeStr":@"",
             
             };
    
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"dateStr"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    
    return oldValue;
}
@end
