//
//  XiaKeMainCell.h
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiaKeMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *commeont;
- (void)setTestWithDict:(NSDictionary *)dict;
@end
