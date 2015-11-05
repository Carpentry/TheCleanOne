//
//  ProjectIntroHeaderView.m
//  TheCleanOne
//
//  Created by lihp on 15/9/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectIntroHeaderView.h"
#import "ProjectInfo.h"

static BOOL titleFlag;
static BOOL introFlag;
static BOOL featureFlag;
static BOOL scheduleFlag;
static BOOL expensesFlag;
static BOOL noticeFlag;
static BOOL contactFlag;

@interface ProjectIntroHeaderView()
{
    NSInteger gSection;

}

@property (nonatomic, weak) UIButton *nameBtn;

//@property (nonatomic, weak) UILabel *introLabel;
@end

@implementation ProjectIntroHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView andTitle:(NSString *)title andSection:(NSInteger)section
{
    NSString *ID = @"headerView";

    ProjectIntroHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[ProjectIntroHeaderView alloc] initWithReuseIdentifier:ID andTitle:title andSection:section];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andSection:(NSInteger)section
{

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitle:title forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageView.contentMode = UIViewContentModeCenter;
        btn.imageView.clipsToBounds = NO;
        [btn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.nameBtn = btn;
        
        gSection = section;
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentRight;
//        [self addSubview:label];
//        self.introLabel = label;
    }
    return self;
}

- (void)setProjectInfo:(ProjectInfo *)projectInfo
{
    _projectInfo = projectInfo;
    
}

- (void)setHeaderViewTitle:(NSString *)title
{
    [self.nameBtn setTitle:title forState:UIControlStateNormal];
}

- (void)nameBtnClick:(id)sender
{

//    static BOOL open;

//    open = !open;

    if (gSection == 0) {
        if (self.block) {
            self.block(titleFlag);
        }
        titleFlag = !titleFlag;
    } else if (gSection == 1) {
        if (self.block) {
            self.block(introFlag);
        }
        introFlag = !introFlag;
    } else if (gSection == 2) {
        if (self.block) {
            self.block(featureFlag);
        }
        featureFlag = !featureFlag;
    } else if (gSection == 3) {
        if (self.block) {
            self.block(scheduleFlag);
        }
        scheduleFlag = !scheduleFlag;
    } else if (gSection == 4) {
        if (self.block) {
            self.block(expensesFlag);
        }
        expensesFlag = !expensesFlag;
    } else if (gSection == 5) {
        if (self.block) {
            self.block(noticeFlag);
        }
        noticeFlag = !noticeFlag;
    } else if (gSection == 6) {
        if (self.block) {
            self.block(contactFlag);
        }
        contactFlag = !contactFlag;
    }
    
    

//    if (self.block) {
//        self.block(open);
//    }
////    self.open = !self.open;
//
//    NSLog(@"-%d--section:%d",open,gSection);
//
////    open = !open;
//    isOpen = !isOpen;
}

//当前的view加载到父控件的时候调用
- (void)didMoveToSuperview
{
    
    if (gSection == 0) {
        if (titleFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }

    } else if (gSection == 1) {
        if (introFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } else if (gSection == 2) {
        if (featureFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } else if (gSection == 3) {
        if (scheduleFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } else if (gSection == 4) {
        if (expensesFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } else if (gSection == 5) {
        if (noticeFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } else if (gSection == 6) {
        if (contactFlag) {
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);//旋转90
        }else{
            self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }
    

}

- (void)layoutSubviews
{
    self.nameBtn.frame = self.bounds;
//    CGFloat w = 150;
//    CGFloat h = self.frame.size.height;
//    CGFloat x = self.frame.size.width - w - 10;
//    CGFloat y = 0;
//    self.introLabel.frame = CGRectMake(x, y, w, h);
}
@end
