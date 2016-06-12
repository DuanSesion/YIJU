//
//  XYUpLoadItem.h
//  XiuYu
//
//  Created by Aaron Yu on 14-10-20.
//  Copyright (c) 2014年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XYLoadItem : NSObject

@property(nonatomic, strong) NSData *fileData;
@property(nonatomic, copy) NSString *category;
@property(nonatomic, copy) NSString *audioTime;
@property(nonatomic, copy) NSString *url;

@end

@interface RMUpLoadItem : NSObject

@property(nonatomic, strong)NSMutableArray *imageArray;
@property(nonatomic, strong)NSMutableArray *audioArray;

- (void)addImage:(NSData *)data forCategory:(NSString *)category;
- (void)addImageUrl:(NSString *)url forCategory:(NSString *)category;
- (void)addAudio:(NSData *)data len:(NSString *)length;
- (void)addAutioUrl:(NSString *)url len:(NSString *)length;
- (void)addImage:(NSData *)data forCategory:(NSString *)category forUrl:(NSString *)url;

- (void)removeAudio;
- (void)removeImage;
- (BOOL)isOverloadForImage;
- (BOOL)haveImage;
- (BOOL)haveAudio;

- (BOOL)haveSendData;

@end
