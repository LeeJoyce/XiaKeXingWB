//
//  XiaKeAskVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/23.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeAskVC.h"

@interface XiaKeAskVC ()
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *detialTextV;

@property (weak, nonatomic) IBOutlet UIButton *upBtn;

@end

@implementation XiaKeAskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)textChanged {
    self.upBtn.enabled = self.titleTF.text.length > 0 && self.detialTextV.text.length > 0;
    if (self.upBtn.enabled == YES) {
        self.upBtn.backgroundColor = WBMainColor;
    }else self.upBtn.backgroundColor = ZYGray(200);
}

- (IBAction)upClick:(id)sender {
    
}

@end
