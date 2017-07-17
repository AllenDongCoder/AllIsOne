//
//  ModelOne.h
//  OneIsAll
//
//  Created by dk on 2017/3/3.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOne : NSObject
/**
 *  日期
 */
@property(nonatomic,copy) NSString * dateStr;
/**
 *  天气
 */
@property(nonatomic,copy) NSString * weatherStr;
/**
 * 图片
 */
@property(nonatomic,copy)NSString * picUrlStr;
/**
 *  标题
 */
@property(nonatomic,copy) NSString * titleStr;
/**
 * pic_info 图片信息
 */
@property(nonatomic,copy) NSString * pic_info;
/**
 *  forward 内容
 */
@property(nonatomic,copy) NSString * forwardStr;
/**
 * auther 作者
 */
@property(nonatomic,copy) NSString * autherStr;
/**
 * 小记
 */
@property(nonatomic,copy) NSString * xiaoJiStr;

/**
 * fansNue点赞数
 */
@property(nonatomic,copy) NSString * fansNumStr;
/**
 * 是否喜欢 0 ，1
 */
@property(nonatomic,copy) NSString * isLikeStr;
/**
 * share btn
 */
@property(nonatomic,copy) NSString * shareStr;
@end
