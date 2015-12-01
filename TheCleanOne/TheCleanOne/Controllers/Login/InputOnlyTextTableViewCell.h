//
//  InputOnlyTextTableViewCell.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/18.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputOnlyTextTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString*);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString*);

- (IBAction)editDidBegin:(id)sender;
- (IBAction)editDidEnd:(id)sender;
- (IBAction)textValueChange:(id)sender;
- (IBAction)btnClicked:(id)sender;
- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr;
@end
