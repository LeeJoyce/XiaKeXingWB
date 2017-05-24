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
        [btn setTitle:[NSString stringWithFormat:@"点赞（%zd）",btn.tag + 1] forState:UIControlStateNormal];
    }else {
        [btn setTitleColor:ZYGray(200) forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"点赞（%zd）",btn.tag] forState:UIControlStateNormal];
    }
}

- (void)setTestWithDict:(NSDictionary *)dict {
    if ([dict[@"icon"] isKindOfClass:[NSData class]]) {
        self.icon.image = [UIImage imageWithData:dict[@"icon"]];
    }else if ([dict[@"icon"] isEqualToString:@"nologin"]) {
        self.icon.image = [UIImage imageNamed:@"login"];
    }else self.icon.image = [UIImage imageNamed:dict[@"icon"]];
  
    self.name.text = dict[@"nick"];
    self.time.text = [NSString stringWithFormat:@"%@",dict[@"time"]];
    self.scenic.text = dict[@"address"];
    self.scenicDetial.text = dict[@"title"];
    [self.Img sd_setImageWithURL:[NSURL URLWithString:dict[@"img_url"]] placeholderImage:[UIImage imageNamed:@"holder"]];
    [self.agree setTitle:[NSString stringWithFormat:@"点赞（%@）",dict[@"agressNum"]] forState:UIControlStateNormal];
    self.agree.tag = [dict[@"agressNum"] integerValue];
}


@end
