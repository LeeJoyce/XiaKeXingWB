//
//  NullView.h
//  移动掌控
//
//  Created by 李昊泽 on 16/4/28.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NullView : UIView
/** 提醒文字 */
@property (nonatomic, copy) NSString *remindText;

+ (void)removeNull;

+ (NullView *)nullView;
@end
