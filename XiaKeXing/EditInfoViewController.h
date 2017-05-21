//
//  EditInfoViewController.h
//  XiaKeXing
//
//  Created by wangzhongyi on 17/5/21.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SaveBlock)();
@interface EditInfoViewController : UIViewController
@property(nonatomic, copy) SaveBlock saveBtnClickBlock;
@end
