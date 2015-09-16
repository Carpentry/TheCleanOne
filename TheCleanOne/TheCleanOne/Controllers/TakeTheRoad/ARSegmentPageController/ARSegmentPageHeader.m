//
//  ARSegmentPageHeader.m
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARSegmentPageHeader.h"

@interface ARSegmentPageHeader ()

@property (nonatomic, strong) NSLayoutConstraint *imageTopConstraint;

@property (nonatomic, strong) UIScrollView *headerSrollView;

@end

@implementation ARSegmentPageHeader




- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _baseConfigs];
    }
    return self;
}


//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self _baseConfigs];
//    }
//    return self;
//}

-(void)_baseConfigs
{
    
//    self.headerSrollView = [[UIScrollView alloc] initWithFrame:scrollView.bounds];
//    for (int i = 0; i < 5; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"Assassin%d.jpg",i+1];
//        UIImage *image = [UIImage imageNamed:imageName];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
//        imageView.image = image;
//        
//        self.headerSrollView.contentMode = UIViewContentModeScaleAspectFill;
//        self.headerSrollView.clipsToBounds = YES;
//        [self.headerSrollView addSubview:imageView];
//    }
//    [self.headerSrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
//        
//        CGRect frame = imageView.frame;
//        frame.origin.x = idx * frame.size.width;
//        imageView.frame = frame;
//    }];
//    [scrollView addSubview:self.headerSrollView];

    
 
    
    
    
//    self.headerSrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerSrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerSrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
//    self.imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.headerSrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//    [self addConstraint:self.imageTopConstraint];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerSrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    

    
    
    
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"listdownload.jpg"];
//    self.imageView.image = [UIImage imageNamed:@"Assassin1.jpg"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    //图片的约束
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    self.imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraint:self.imageTopConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
