//
//  PostHeaderImage.h
//  ZJHTCarOwner
//
//  Created by 汉子科技 on 15/2/6.
//  Copyright (c) 2015年 汉子科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^returnImageBlock)(UIImage *image);

@interface RMPhotoImage : NSObject<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;

@property(nonatomic,copy)returnImageBlock myImageBlock;

@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,strong)UIViewController *vc;

+(RMPhotoImage *)sharePostHeaderImage;

-(void)changeHeaderVC:(UIViewController *)vc imageView:(returnImageBlock)finishedImageView isEdit:(BOOL)edit;

-(void)changeHeaderVC:(UIViewController *)vc imageViewWX:(returnImageBlock)finishedImageView camera:(BOOL)isCamera;

@end
