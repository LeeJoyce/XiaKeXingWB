//
//  XiaKeMainCell.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeMainCell.h"

@interface XiaKeMainCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *scenic;
@property (weak, nonatomic) IBOutlet UILabel *scenicDetial;
@property (weak, nonatomic) IBOutlet UIButton *commeont;
@property (weak, nonatomic) IBOutlet UIButton *agree;

@property (weak, nonatomic) IBOutlet UIImageView *Img;


@end

@implementation XiaKeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.agree.layer.borderColor = WBMainColor.CGColor;
    self.agree.layer.borderWidth = 1;
    [self.agree addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.Img.image = [[UIImage imageNamed:@"timg"] getWantImageWithSize:CGSizeMake(200, 100)];
}

- (void)agreeClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [btn setTitleColor:WBMainColor forState:UIControlStateNormal];
    }else [btn setTitleColor:ZYGray(200) forState:UIControlStateNormal];
}

- (void)setTestWithDict:(NSDictionary *)dict {
    self.name.text = dict[@"nick"];
}


@end
