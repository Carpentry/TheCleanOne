//
//  EaseUserHeaderView.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/14.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#import "EaseUserHeaderView.h"
#import "UITabImageView.h"
#import "Masonry.h"

@interface EaseUserHeaderView ()
@property (strong, nonatomic) UITabImageView *userIconView;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIButton *fansCountBtn, *followsCountBtn, *followBtn;
@property (strong, nonatomic) UIView *splitLine, *coverView; //分割线和蒙板
@property (assign, nonatomic) CGFloat userIconViewWith;
@end

@implementation EaseUserHeaderView
+ (id)userHeaderViewWithUser:(User *)user image:(UIImage *)image
{
    if (!user || !image) {
        return nil;
    }
    EaseUserHeaderView *headerView = [[EaseUserHeaderView alloc] init];
    headerView.userInteractionEnabled = YES;
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.curUser = user;
    headerView.bgImage = image;

    [headerView configUI];
    return headerView;
}

- (void)setCurUser:(User *)curUser{
    _curUser = curUser;
    [self updateData];
}

- (void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    [self updateData];
}

- (void)configUI
{
    if (!_curUser) {
        return;
    }
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:_coverView];
//        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
    }
    [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150 * ([UIScreen mainScreen].bounds.size.width/320))];
    
    
    __weak typeof(self) weakSelf = self;
    if (!_fansCountBtn) {
        _fansCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_fansCountBtn];
    }
    if (!_followsCountBtn) {
        _followsCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followsCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_followsCountBtn];
    }
    if (!_splitLine) {
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = [UIColor grayColor];
        [self addSubview:_splitLine];
    }
    if (!_followBtn) {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_followBtn];
    }else {
        _followBtn.hidden = YES;
    }
    
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.font = [UIFont boldSystemFontOfSize:18];
        _userLabel.textColor = [UIColor whiteColor];
        _userLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_userLabel];
    }
    
    if (!_userIconView) {
        _userIconView = [[UITabImageView alloc] init];
        [self addSubview:_userIconView];
    }
    
    if (kDevice_Is_iPhone6Plus) {
        _userIconViewWith = 100;
    }else if (kDevice_Is_iPhone6) {
        _userIconViewWith = 90;
    }else {
        _userIconViewWith = 75;
    }
    
  
    //约束
    
    
    [_fansCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(_splitLine.mas_left).offset((-15) * ([UIScreen mainScreen].bounds.size.width/320));
        make.bottom.equalTo(self.mas_bottom).offset((-15) * ([UIScreen mainScreen].bounds.size.width/320));
    }];
    
    [_followsCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(_splitLine.mas_right).offset(15 * ([UIScreen mainScreen].bounds.size.width/320));
        make.height.equalTo(@[_fansCountBtn.mas_height, @(20 * ([UIScreen mainScreen].bounds.size.width/320))]);
    }];
    
    [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(@[_fansCountBtn, _followsCountBtn]);
        make.size.mas_equalTo(CGSizeMake(0.5, 15));
    }];
    

    
    
    
//    if (!isMe) {
//        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(_fansCountBtn.mas_top).offset(-20);
//            make.size.mas_equalTo(CGSizeMake(128, 39));
//            make.centerX.equalTo(self);
//        }];
//        
//        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(_followBtn.mas_top).offset((-25) * ([UIScreen mainScreen].bounds.size.width/320));
//            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
//        }];
//    }else{
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_fansCountBtn.mas_top).offset((-20) * ([UIScreen mainScreen].bounds.size.width/320));
            make.height.mas_equalTo(20 * ([UIScreen mainScreen].bounds.size.width/320));
        }];
//    }
    
    [_userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_userIconViewWith, _userIconViewWith));
        make.bottom.equalTo(_userLabel.mas_top).offset(-15);
        make.centerX.equalTo(self);
    }];
    
    

    //    left, right 只是占位，使名字和性别能居中显示
    UIView *left = [[UIView alloc] init], *right = [[UIView alloc] init];
    [self addSubview:left];
    [self addSubview:right];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(right);
        make.left.equalTo(self);
        make.right.equalTo(_userLabel.mas_left);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(_userLabel.mas_right);
        make.centerY.equalTo(@[_userLabel, left]);
    }];
    
    [self updateData];
    
}

- (NSMutableAttributedString*)getStringWithTitle:(NSString *)title andValue:(NSString *)value{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", value, title]];
    [attrString addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],
                                NSForegroundColorAttributeName : [UIColor whiteColor]}
                        range:NSMakeRange(0, value.length)];
    
    [attrString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName : [UIColor whiteColor]}
                        range:NSMakeRange(value.length+1, title.length)];
    return  attrString;
}

- (void)updateData{
    if (!_userIconView) {
        return;
    }
    self.image = _bgImage;
//    [_userIconView sd_setImageWithURL:[_curUser.avatar urlImageWithCodePathResize:2* _userIconViewWith] placeholderImage:kPlaceholderMonkeyRoundWidth(54.0)];

//    _userLabel.text = _curUser.name;
    _userLabel.text = SHARE.userInfo.nickname;
    [_userLabel sizeToFit];
    
    [_fansCountBtn setAttributedTitle:[self getStringWithTitle:@"粉丝" andValue:_curUser.fans_count.stringValue] forState:UIControlStateNormal];
    [_followsCountBtn setAttributedTitle:[self getStringWithTitle:@"关注" andValue:_curUser.follows_count.stringValue] forState:UIControlStateNormal];
    
    NSString *imageName;
    if (_curUser.followed.boolValue) {
        if (_curUser.follow.boolValue) {
            imageName = @"n_btn_followed_both";
        }else{
            imageName = @"n_btn_followed_yes";
        }
    }else{
        imageName = @"n_btn_followed_not";
    }
    [_followBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
