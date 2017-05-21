//
//  AnimalKindsCell.m
//  animalShop
//
//  Created by wangzhongyi on 17/5/18.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "ScenicKindsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ScenicKindsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *animalImageView;
@property (weak, nonatomic) IBOutlet UILabel *animalNameLabel;

@end

@implementation ScenicKindsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ScenicModel *)model
{
    _model = model;
    _animalNameLabel.text = model.name;
    [_animalImageView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"load"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
