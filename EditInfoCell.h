//
//  EditInfoCell.h
//  XiaKeXing
//
//  Created by wangzhongyi on 17/5/21.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoCell : UITableViewCell
- (void)setSourceWithIndex:(NSIndexPath *)index;
@property (weak, nonatomic) IBOutlet UITextField *infoTextfield;
@end
