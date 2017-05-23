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
@property (weak, nonatomic) IBOutlet UIButton *regised;

@end

@implementation XiaKeUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self iconBaseSet];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setViewsWithIsLogin];
}

- (void)iconBaseSet {
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.icon addGestureRecognizer:tap];
    
    self.icon.layer.cornerRadius = self.icon.zy_width * 0.5;
    self.icon.layer.masksToBounds = YES;
}

- (void)iconClick {
    if ([userTokenTool isLogin] == YES) {
        [self setPhotoAlert];
    }else {
        
    }
}

- (void)setViewsWithIsLogin {
    if ([userTokenTool isLogin] == YES) {
        if ([userTokenTool getIcon] != nil) {
            self.icon.image = [UIImage imageWithData:[userTokenTool getIcon]];
        }
        if ([userTokenTool getName].length != 0) {
            self.name.text = [userTokenTool getName];
        }else self.name.text = @"匿名用户";
        
        self.myInterested.hidden = NO;
        self.userInfo.hidden = NO;
        self.Question.hidden = NO;
        self.regisBtn.hidden = YES;
        self.regised.hidden = NO;
    }else {
        self.name.text = @"未登录";
        self.icon.image = [UIImage imageNamed:@"login"];
        self.myInterested.hidden = YES;
        self.userInfo.hidden = YES;
        self.Question.hidden = YES;
        self.regisBtn.hidden = NO;
        self.regised.hidden = YES;
    }
}

- (IBAction)regisClick:(id)sender {
    [self.navigationController pushViewController:[[LoginViewC alloc] init] animated:YES];
}

- (IBAction)regisedToken:(id)sender {
    [userTokenTool removeUserKey];
    [self setViewsWithIsLogin];
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
