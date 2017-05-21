//
//  InfoCell.m
//  小蜜蜂邮包包
//
//  Created by 李昊泽 on 16/7/14.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import "InfoCell.h"

@interface InfoCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@end
@implementation InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSourceWithIndex:(NSIndexPath *)index
{
    switch (index.row) {
        case 0:
            self.leftLabel.text = @"用户名";
            self.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUserName];
            break;
          
        case 1:
            self.leftLabel.text = @"性别";
            self.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUserSex];
            break;
            
        case 2:
            self.leftLabel.text = @"所在地";
            self.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUserSite];
            break;
            
        case 3:
            self.leftLabel.text = @"个人介绍";
            self.rightLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUserIntroduce];
            break;
            

        default:
            break;
    }
}

@end
