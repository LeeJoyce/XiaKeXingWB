//
//  ImagePreview.m
//  移动掌控
//
//  Created by 李昊泽 on 17/1/12.
//  Copyright © 2017年 dianbo. All rights reserved.
//

#import "ImagePreview.h"

@interface ImagePreview ()
/** imageV  */
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ImagePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZYColor(100, 100, 100) colorWithAlphaComponent:0.7];
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPreview)];
        [self addGestureRecognizer:tap];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:0];
        [deleteBtn setBackgroundColor:[UIColor redColor]];
        deleteBtn.frame = CGRectMake(ZYScreenSize.width * 0.2, ZYScreenSize.height - 100, ZYScreenSize.width * 0.6, 34);
        [self addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deletePreview) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setPreviewImage:(UIImage *)previewImage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = previewImage;
    });
    
}

- (void)deletePreview
{
    [self clickPreview];
    
    if (self.delete) {
        self.delete(self.imageIndex);
    }
}

- (void)clickPreview
{
    [self removeFromSuperview];
    self.imageView.image = nil;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, ZYScreenSize.width, ZYScreenSize.height - 200)];
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [ZYColor(100, 100, 100) colorWithAlphaComponent:0.02];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
