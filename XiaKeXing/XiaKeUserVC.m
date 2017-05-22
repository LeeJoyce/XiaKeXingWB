//
//  XiaKeUserVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeUserVC.h"
#import "XiaKeInterestedTVC.h"
#import "XiaKeQuestionVC.h"
#import "XiaKeUserInfoVC.h"
#import "LoginViewC.h"

@interface XiaKeUserVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *myInterested;
@property (weak, nonatomic) IBOutlet UIButton *userInfo;
@property (weak, nonatomic) IBOutlet UIButton *Question;
@property (weak, nonatomic) IBOutlet UIButton *regisBtn;

@end

@implementation XiaKeUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];\
    [self.icon addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setViewsWithIsLogin];
}

- (void)iconClick {
    if ([userTokenTool isLogin] == YES) {
        [self setPhotoAlert];
    }else {
    }
}

- (void)setViewsWithIsLogin {
    if ([userTokenTool isLogin] == YES) {
        self.myInterested.hidden = NO;
        self.userInfo.hidden = NO;
        self.Question.hidden = NO;
        self.regisBtn.hidden = YES;
    }else {
        self.myInterested.hidden = YES;
        self.userInfo.hidden = YES;
        self.Question.hidden = YES;
        self.regisBtn.hidden = NO;
    }
}

- (IBAction)regisClick:(id)sender {
    [self.navigationController pushViewController:[[LoginViewC alloc] init] animated:YES];
}

- (IBAction)InterestedClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeInterestedTVC alloc] init] animated:YES];
}
- (IBAction)userInfoClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeUserInfoVC alloc] init] animated:YES];
}
- (IBAction)questionClick:(id)sender {
    [self.navigationController pushViewController:[[XiaKeQuestionVC alloc] init] animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *photo = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    NSData *ImageData;
    if (UIImagePNGRepresentation(photo) == nil)
    {
        ImageData = UIImageJPEGRepresentation(photo, 1.0);
    }else
        ImageData = UIImagePNGRepresentation(photo);
    
    self.icon.image = photo;
    
    [[NSUserDefaults standardUserDefaults] setObject:ImageData forKey:@"icon"];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPhotoAlert {
    ZYSelf
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *playPhote = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setPickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *choses = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setPickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    [alertVC addAction:cancelAct];
    [alertVC addAction:playPhote];
    [alertVC addAction:choses];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setPickerControllerWithSourceType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *pickerPlay = [[UIImagePickerController alloc] init];
    pickerPlay.sourceType = type;
    pickerPlay.allowsEditing = YES;
    pickerPlay.delegate = self;
    [self.navigationController presentViewController:pickerPlay animated:YES completion:nil];
}


@end
