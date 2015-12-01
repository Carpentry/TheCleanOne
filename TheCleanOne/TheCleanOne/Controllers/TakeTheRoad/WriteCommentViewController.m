//
//  WriteCommentViewController.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/25.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "WriteCommentViewController.h"
#import "CWStarRateView.h"
#import "UITools.h"
#import "LYLHttpTool.h"
@interface WriteCommentViewController ()
{
    CGFloat textViewHeight;
    CWStarRateView *ratingBar;
}
@property (weak, nonatomic) IBOutlet UIView *ratingBarView;
@property (weak, nonatomic) IBOutlet UITextView *writeCommentTextView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
- (IBAction)checkBoxAction:(id)sender;
- (IBAction)commentSubmitAction:(id)sender;
@end

@implementation WriteCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表评价";
    [UITools setNavigationState:@"返回" leftAction:@selector(back) rightBtnStr:@"完成" rightAction:@selector(editFinish) rightBtnStateSelected:nil titleStr:@"发表评价" forViewController:self];
    
    //UITextView
    _writeCommentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _writeCommentTextView.layer.borderWidth = 2;
    self.automaticallyAdjustsScrollViewInsets = NO;//光标移动到起始位置
    textViewHeight = _writeCommentTextView.frame.size.height;
    
    //ratingBar
    ratingBar = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, self.ratingBarView.bounds.size.width*2/3, self.ratingBarView.bounds.size.height) numberOfStars:5];
    ratingBar.scorePercent = 1;
    ratingBar.hasAnimation = YES;
    ratingBar.allowIncompleteStar = YES;
    [self.ratingBarView addSubview:ratingBar];
    
    //注册通知
    [self registerForKeyboardNotifications];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editFinish
{
    [self.writeCommentTextView resignFirstResponder];
}

- (IBAction)checkBoxAction:(id)sender {
    self.checkBoxBtn.selected = !self.checkBoxBtn.selected;
    
}

- (IBAction)commentSubmitAction:(id)sender {
    [self saveEvaluation:self.projectId andGrade:(ratingBar.scorePercent * 5) andContent:self.writeCommentTextView.text andAnonymous:self.checkBoxBtn.selected];
}

//pragma mark keyboardNotifications
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGFloat keyboardHeight = MIN(keyboardSize.width, keyboardSize.height);
    int height  = self.view.bounds.size.height - keyboardHeight - _writeCommentTextView.frame.origin.y;
    if (height > 0) {
        [UIView animateWithDuration:0.5 animations:^{
           _writeCommentTextView.frame = CGRectMake(_writeCommentTextView.frame.origin.x, _writeCommentTextView.frame.origin.y, _writeCommentTextView.bounds.size.width, height);
        } completion:^(BOOL finished) {
            if (finished) {
                
            }
        }];

    }
    
}

- (void)keyboardWillHidden:(NSNotification *)notif
{
    _writeCommentTextView.frame = CGRectMake(_writeCommentTextView.frame.origin.x, _writeCommentTextView.frame.origin.y, _writeCommentTextView.bounds.size.width, textViewHeight);
}


- (void)saveEvaluation:(NSInteger)getProjectId andGrade:(CGFloat)grade andContent:(NSString *)content andAnonymous:(BOOL)isAno
{
    NSNumber *l_tmp_grade = [NSNumber numberWithFloat:grade];
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/SaveEvaluation"];
    isAno = !isAno;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInteger:getProjectId],@"projectId",[NSNumber numberWithInteger:[SHARE.userInfo.userId integerValue]],@"userId",l_tmp_grade,@"grade",content,@"content",[NSNumber numberWithBool:isAno],@"anonymous",nil];
    NSLog(@"%@",param);
    [LYLHttpTool GET:path parameters:param success:^(id responseObject) {
        if ([responseObject[@"flag"] intValue] == 1) {
//            NSString *str = responseObject[@"content"];
//            NSData  *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            [self.navigationController popViewControllerAnimated:YES];
  
        }else if([responseObject[@"flag"] intValue] == 0){
            NSLog(@"返回失败");
        }else{
            NSLog(@"服务器异常");
        }
    } failure:^(NSError *error) {
        NSLog(@"%s:%@",__func__,error);
    }];
    
}

@end
