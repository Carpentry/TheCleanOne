//
//  TitleValueTableViewCell.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/21.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleValueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

- (void)setTitle:(NSString *)title andValue:(NSString *)value;

@end
