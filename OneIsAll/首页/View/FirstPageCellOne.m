//
//  FirstPageCellOne.m
//  OneIsAll
//
//  Created by dk on 2017/3/1.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "FirstPageCellOne.h"
@interface FirstPageCellOne()
/**
 *头部日期
 */
@property(nonatomic,strong)UILabel * dateLabel;
/**
 *  天气
 */
@property(nonatomic,strong)UILabel * weatherLabel;
/**
 *  头部图片
 */
@property (nonatomic,strong)UIImageView * headImageView;
/**
 *  title
 */
@property(nonatomic,strong)UILabel *titleLabel;
/**
 *  描述
 */
@property(nonatomic,strong)UILabel * forwardLabel;
/**
 *  文字来源
 */
@property(nonatomic,strong)UILabel * words_infromLabel;
/**
 *  小记
 */
@property(nonatomic,strong)UILabel * xiaoJiLabel;
/**
 *  粉丝点赞数
 */
@property(nonatomic,strong) UILabel * fansLabel;
/*
 * 点赞按钮
 */
@property(nonatomic,strong) UIButton  * likeBtn;
///分享按钮
@property(nonatomic,strong) UIButton * shareBtn;

@end
@implementation FirstPageCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)setModel:(ModelOne *)model{
    self.dateLabel.text = model.dateStr;
    self.weatherLabel.text = model.weatherStr;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrlStr] placeholderImage:[UIImage imageNamed:@"personalBackgroundImage"]];
    self.titleLabel.text = model.titleStr;
    self.forwardLabel.text = model.forwardStr;
    self.fansLabel.text = model.fansNumStr;
    NSString * imageName = model.isLikeStr == 0?@"contentLikedSelectd":@"contentLikedUnselectd";
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"contentShare"] forState:UIControlStateNormal];
    
}
#pragma mark - 布局
- (void)layoutSubviews{
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.equalTo(@30);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dateLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH -10, 15));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.weatherLabel.mas_bottom).offset(10);
        make.height.equalTo(@120);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.forwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    [self.words_infromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(@20);
    }];
    [self.xiaoJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.words_infromLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.words_infromLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-10);
        make.top.equalTo(self.shareBtn);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeBtn.mas_left).offset(-10);
        make.top.equalTo(self.shareBtn);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
    }];
    
    
}
#pragma mark -getter
-(UILabel *)dateLabel{
    return HT_LAZY(_dateLabel, ({
        UILabel * datelabel = [UILabel new];
        datelabel.font = HTSetFont(@"PingFang SC ", 20);
        datelabel.text = @"2017 / 03 / 01";
        datelabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:datelabel];
        datelabel;
    }));
}
-(UILabel *)weatherLabel{
    return HT_LAZY(_weatherLabel, ({
        UILabel * weatherLabel = [UILabel new];
        weatherLabel.font = HTSetFont(@"PingFang SC", 10);
        weatherLabel.textAlignment = NSTextAlignmentCenter;
        weatherLabel.text = @"多云，深圳";
        [self.contentView addSubview:weatherLabel];
        weatherLabel;
    }));
    
}
- (UIImageView * )headImageView{
    return HT_LAZY(_headImageView, ({
        UIImageView * imageView =[UIImageView new];
        [self.contentView addSubview:imageView];
        imageView;
    }));
}
- (UILabel * )titleLabel{
    return HT_LAZY(_titleLabel, ({
        UILabel * titleLabel = [UILabel new];
        titleLabel.font = HTSetFont(@"PingFang SC", 10);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        titleLabel;
    }));
}
- (UILabel *)forwardLabel{
    return HT_LAZY(_forwardLabel, ({
        UILabel * forwardLabel =[UILabel new];
        forwardLabel.textAlignment = NSTextAlignmentLeft;
        forwardLabel.font =HTSetFont(@"PingFang-SC", 15);
        [self.contentView addSubview:forwardLabel];
        forwardLabel;
    }));
}
- (UILabel *)words_infromLabel{

    return HT_LAZY(_words_infromLabel, ({
        UILabel * wordsformLab =[UILabel new];
        wordsformLab.textAlignment = NSTextAlignmentCenter;
        wordsformLab.font = HTSetFont(@"PingFang-SC", 10.0f);
        [self.contentView addSubview:wordsformLab];
        wordsformLab;
    }));

}
- (UILabel *)xiaoJiLabel{
    return HT_LAZY(_xiaoJiLabel, ({
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = HTSetFont(@"PingFang-SC", 10);
        label.text = @"小记";
        [self.contentView addSubview:label];
        label;
    }));
    
}
- (UILabel *)fansLabel{
    return HT_LAZY(_fansLabel, ({
        UILabel * fanslabel =[UILabel new];
        fanslabel.textAlignment = NSTextAlignmentRight;
        fanslabel.font = HTSetFont(@"PingFang-SC", 10);
        [self.contentView addSubview:fanslabel];
        fanslabel;
    }));
}
- (UIButton *)likeBtn{
    return HT_LAZY(_likeBtn, ({
        UIButton * btn =[UIButton new];
        //contentLikedSelectd方法
        [btn setBackgroundImage:[UIImage imageNamed:@"contentLikeSelectd"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        btn;
    }));
}
- (UIButton *)shareBtn{
    return HT_LAZY(_shareBtn , ({
    
        UIButton * btn = [UIButton new];
        [btn setBackgroundImage:[UIImage imageNamed:@"contentShare"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        btn;
    }));
}

@end
