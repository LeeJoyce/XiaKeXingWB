//
//  WebViewController.h
//  移动掌控
//
//  Created by 李昊泽 on 16/1/28.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
/** web需要的链接 */
@property (nonatomic, copy) NSString *url;

/** 导航栏标题 */
@property (nonatomic, copy) NSString *navTitle;
@end
