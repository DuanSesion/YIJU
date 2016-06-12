//
//  PostHeaderImage.m
//  ZJHTCarOwner
//
//  Created by 汉子科技 on 15/2/6.
//  Copyright (c) 2015年 汉子科技. All rights reserved.
//

#import "RMPhotoImage.h"

@implementation RMPhotoImage

static RMPhotoImage *postHeaderImage;

+(RMPhotoImage *)sharePostHeaderImage
{
    if (postHeaderImage == nil) {
        
        postHeaderImage = [[RMPhotoImage alloc] init];
    }
    
    return postHeaderImage;
}

// 修改头像调用
-(void)changeHeaderVC:(UIViewController *)vc imageView:(returnImageBlock)finishedImageView isEdit:(BOOL)edit
{
    //指向目标UIViewController
    _vc = vc;
    
    _myImageBlock = finishedImageView;
    
    //版本判断
    if ([[UIDevice currentDevice]systemVersion].floatValue>=8.0) {
        
        UIAlertController *sheet =[UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        sheet.popoverPresentationController.sourceView = vc.view;
        
        sheet.popoverPresentationController.sourceRect = CGRectMake(vc.view.bounds.size.width, vc.view.bounds.size.height, 1.0, 1.0);
        
        [sheet addAction:[UIAlertAction actionWithTitle:@"立即拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           
            [self takePoto:YES];
            
        }]];
        
        
        [sheet addAction:[UIAlertAction actionWithTitle:@"从本地相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          
            [self selectPhoto:YES];
            
        }]];
        
        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [_vc presentViewController:sheet animated:YES completion:nil];
        
    }else{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"从本地相册获取", nil];
        
        sheet.tag = 999;
        
        sheet.delegate = self;
        
        [sheet showInView:_vc.view];
        
    }
    
    
}

-(void)changeHeaderVC:(UIViewController *)vc imageViewWX:(returnImageBlock)finishedImageView camera:(BOOL)isCamera
{
    _vc = vc;
    _myImageBlock = finishedImageView;

    if (isCamera) {
        [self takePoto:NO];
    }else{
        [self selectPhoto:NO];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
    if (buttonIndex == 0) {
       
        //立即拍照
        [self takePoto:YES];
        
    }else{
       
        //从本地相册获取
        [self selectPhoto:YES];
    }
    
}

//照相
-(void)takePoto:(BOOL)isEdit
{
    
    _isEdit = isEdit;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"模拟器不可以使用摄像头!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
   
    picker.allowsEditing = isEdit;
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [_vc presentViewController:picker animated:YES completion:nil];
    
    [self.imagePickerController takePicture];
    
}

//相册选择
-(void)selectPhoto:(BOOL)isEdit
{
    _isEdit = isEdit;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = isEdit;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [_vc presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate  回调图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = [UIImage new];
    
    if (_isEdit) {
        chosenImage = info[UIImagePickerControllerEditedImage];
    }else{
        chosenImage = info[UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self photoFromImagePickerView:chosenImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


-(void)photoFromImagePickerView:(UIImage*) photo {
    
    //返回Image 设置指定UIViewController的ImageView
    _myImageBlock(photo);
    
}

@end
