//
//  SelectLocationMapController.h
//  移动掌控
//
//  Created by 李昊泽 on 17/1/11.
//  Copyright © 2017年 dianbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLocationMapController : UIViewController
/** 点击确定将地址传过去 */
@property (nonatomic, copy) void(^certainBtnClick)(NSString *address);
@end
