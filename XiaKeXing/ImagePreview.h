//
//  ImagePreview.h
//  移动掌控
//
//  Created by 李昊泽 on 17/1/12.
//  Copyright © 2017年 dianbo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagePreview : UIView
/** 预览的图片  */
@property (nonatomic, strong) UIImage *previewImage;
//展示图片的下标
@property (nonatomic, assign) NSInteger imageIndex;
/** 删除预览图片 */
@property (nonatomic, copy) void(^delete)(NSInteger index);
@end
