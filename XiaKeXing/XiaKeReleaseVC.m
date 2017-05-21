//
//  XiaKeReleaseVC.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeReleaseVC.h"
#import "ImagePreview.h"
#import "SelectLocationMapController.h"
#import "SuccessSubmitController.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface XiaKeReleaseVC ()<UIImagePickerControllerDelegate,UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate>{
    NSInteger _btnCount;
}
@property (weak, nonatomic) IBOutlet UITextField *sceneTextField;
@property (weak, nonatomic) IBOutlet UITextView *releaseTextView;
@property (weak, nonatomic) IBOutlet UIView *middlePhotoView;
@property (weak, nonatomic) IBOutlet UIButton *openAlbumBtn;
/** 按钮数组  */
@property (nonatomic, strong) NSMutableArray <UIButton *>*btnArray;
/** 图片数组  */
@property (nonatomic, strong) NSMutableArray <UIImage *>*imageArray;
/** 预览视图  */
@property (nonatomic, strong) ImagePreview *preview;
/** 提醒框  */
@property (nonatomic, strong) UIAlertController *sheetAlertC;
/** 相机控制器  */
@property (nonatomic, strong) UIImagePickerController *imagePickerC;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@end

@implementation XiaKeReleaseVC
static CGFloat photoNums = 4;
static CGFloat photoBtnWidth = 50;
static CGFloat photoBtnMargin = 10;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布趣事";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *wantImage = [[UIImage imageNamed:@"add"] getWantImageWithSize:CGSizeMake(20, 20)];
    [self.openAlbumBtn setImage:wantImage forState:0];
    self.openAlbumBtn.layer.borderWidth = 1;
    self.openAlbumBtn.layer.borderColor = ZYColor(220, 220, 220).CGColor;
    self.openAlbumBtn.layer.cornerRadius = 2;
    
    self.releaseTextView.layer.borderWidth = 1;
    self.releaseTextView.layer.borderColor = ZYColor(220, 220, 220).CGColor;
    self.releaseTextView.layer.cornerRadius = 2;
    
    [self setupMiddleView];
    [self setupRelease];
    
    _btnCount = 0;
}

- (void)setupRelease
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(releaseThing)];
    [right setTintColor:[UIColor lightGrayColor]];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setupMiddleView
{
    for (int i = 0; i < photoNums; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = ZYColor(220, 220, 220).CGColor;
        btn.layer.cornerRadius = 2;
        btn.zy_higth = photoBtnWidth;
        btn.zy_width = photoBtnWidth;
        btn.zy_y = (self.middlePhotoView.zy_higth - photoBtnWidth) / 2;
        btn.zy_x = 20 + i * (photoBtnMargin + photoBtnWidth);
        [self.middlePhotoView addSubview:btn];
        btn.hidden = YES;
        [self.btnArray addObject:btn];
        [btn addTarget:self action:@selector(imagePreview:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//预览图片
- (void)imagePreview:(UIButton *)photoBtn
{
    NSInteger count = photoBtn.tag;
    ImagePreview *preview = [[ImagePreview alloc] initWithFrame:self.view.bounds];
    self.preview = preview;
    self.preview.imageIndex = count;
    [self.view addSubview:self.preview];
    self.preview.previewImage = self.imageArray[count];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *originalImage = self.imageArray[count];
        self.preview.previewImage = [self getCompressImage:originalImage];
    });
    
    //删除图片
    __weak __typeof__(self) weakSelf = self;
    self.preview.delete = ^(NSInteger index){
        //删除数据源
        [weakSelf.imageArray removeObjectAtIndex:index];
        
        for (int i = 0; i < photoNums; i++) {
            if (i < weakSelf.imageArray.count) {
                [weakSelf.btnArray[i] setBackgroundImage:weakSelf.imageArray[i] forState:0];
            }else {
                weakSelf.btnArray[i].hidden = YES;
            }
        }
        
        weakSelf.openAlbumBtn.hidden = NO;
        weakSelf.openAlbumBtn.frame = weakSelf.btnArray[weakSelf.imageArray.count].frame;
        
        _btnCount -= 1;
        
    };
    
}

- (UIImage *)getCompressImage:(UIImage *)originalImage
{
    
    NSData *compressData = UIImageJPEGRepresentation(originalImage, 0.5);
    UIImage *compressImage = [UIImage imageWithData:compressData];
    CGFloat scaleSize = 0.8;
    UIGraphicsBeginImageContext(CGSizeMake(compressImage.size.width * scaleSize, compressImage.size.height * scaleSize));
    [compressImage drawInRect:CGRectMake(0, 0, compressImage.size.width * scaleSize, compressImage.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    [self.imageArray addObject:image];
    
    if (self.middleLabel.hidden == NO) {
        self.middleLabel.hidden = YES;
    }
    
    UIButton *btn = self.btnArray[_btnCount];
    btn.hidden = NO;
    [btn setBackgroundImage:image forState:0];
    
    _btnCount += 1;
    if (self.openAlbumBtn.hidden == NO && _btnCount == self.btnArray.count) {
        self.openAlbumBtn.hidden = YES;
    } else {
        self.openAlbumBtn.frame = self.btnArray[_btnCount].frame;
    }
    
    [_imagePickerC dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - selector
- (IBAction)selectLocation:(id)sender {
    SelectLocationMapController *selectLocation = [[SelectLocationMapController alloc] init];
    selectLocation.certainBtnClick = ^(NSString *address){
        _sceneTextField.text = address;
    };
    
    [self.navigationController pushViewController:selectLocation animated:YES];
}

- (IBAction)addPhoto:(id)sender {
    [self presentViewController:self.sheetAlertC animated:YES completion:nil];
}

//发表
- (void)releaseThing
{
    SuccessSubmitController *success = [[SuccessSubmitController alloc] init];
    [self.navigationController pushViewController:success animated:YES];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazy
- (UIAlertController *)sheetAlertC
{
    if (!_sheetAlertC) {
        _sheetAlertC = [UIAlertController alertControllerWithTitle:@"选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.imagePickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:self.imagePickerC animated:YES completion:nil];
        }];
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.imagePickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [weakSelf presentViewController:self.imagePickerC animated:YES completion:nil];
        }];
        
//        UIAlertAction *playPhote = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            [weakSelf setPickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
//        }];
//        
//        UIAlertAction *choses = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [weakSelf setPickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [_sheetAlertC dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [_sheetAlertC addAction:albumAction];
        [_sheetAlertC addAction:takePhotoAction];
        [_sheetAlertC addAction:cancleAction];
    }
    return _sheetAlertC;
}

- (UIImagePickerController *)imagePickerC
{
    if (!_imagePickerC) {
        _imagePickerC = [[UIImagePickerController alloc] init];
        _imagePickerC.delegate = self;
        _imagePickerC.allowsEditing = YES;
    }
    return _imagePickerC;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray<UIImage *> *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
