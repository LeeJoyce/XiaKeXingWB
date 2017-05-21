//
//  NullView.m
//  移动掌控
//
//  Created by 李昊泽 on 16/4/28.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import "NullView.h"

@interface NullView ()
@property (weak, nonatomic) IBOutlet UILabel *nullLabel;
@end
@implementation NullView
- (void)awakeFromNib
{
   
    
}

- (void)setRemindText:(NSString *)remindText
{
    self.nullLabel.text = remindText;
}


+ (void)removeNull
{
    [[self nullView] removeFromSuperview];
}

+ (NullView *)nullView
{
    static NullView *nullView;
    
    if (!nullView) {
        nullView = [[NSBundle mainBundle] loadNibNamed:@"NullView" owner:self options:nil].firstObject
        ;
    }
    return nullView;
}

@end
