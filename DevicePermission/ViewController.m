//
//  ViewController.m
//  DevicePermission
//
//  Created by Jyh on 15/8/24.
//  Copyright (c) 2015年 iyhjiang.com. All rights reserved.
//

#import "ViewController.h"
#import "YHUtil.h"

@interface ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)onButtonClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(UIButton *)sender {

    switch (sender.tag) {
        case MyDeviceCamera:
            if ([YHUtil isAllowCamera]) {
                [self openCamera];
            } else {
                [self alertMessage:@"请打开 设置-隐私-相机 来进行设置"];
            }
            break;
        case MyDevicePhotoAlbum:
            if ([YHUtil isAllowPhotoAlbum]) {
                [self openPhotoAlbum];
            } else {
                [self alertMessage:@"请打开 设置-隐私-照片 来进行设置"];
            }
            break;
        case MyDeviceMicophone:
            if ([YHUtil isAllowDeviceMicophone]) {
                [self alertMessage:@"麦克风可访问"];
            } else {
                [self alertMessage:@"请打开 设置-隐私-麦克风 来进行设置"];
            }
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark - Aciton

/**
 *  打开相机
 */
- (void)openCamera
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];//进入照相界面
}

/**
 *  打开相册
 */
- (void)openPhotoAlbum
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];   
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:^{
        
    }];
}

- (void)alertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
