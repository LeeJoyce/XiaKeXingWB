//
//  EditInfoCell.m
//  XiaKeXing
//
//  Created by wangzhongyi on 17/5/21.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "EditInfoCell.h"

@interface EditInfoCell ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@end

@implementation EditInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSourceWithIndex:(NSIndexPath *)index
{
    switch (index.row) {
        case 0:
            self.leftLabel.text = @"用户名";
            self.infoTextfield.placeholder = @"请编辑您的姓名";
            break;
            
        case 1:
            self.leftLabel.text = @"性别";
            self.infoTextfield.placeholder = @"请输入您的性别";
            break;
            
        case 2:
            self.leftLabel.text = @"所在地";
            self.infoTextfield.placeholder = @"请输入您的所在地";
            break;
            
        case 3:
            self.leftLabel.text = @"个人介绍";
            self.infoTextfield.placeholder = @"一句话介绍你自己";
            break;

        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
