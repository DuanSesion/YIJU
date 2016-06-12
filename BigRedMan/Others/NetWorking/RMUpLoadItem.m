//
//  XYUpLoadItem.m
//  XiuYu
//
//  Created by Aaron Yu on 14-10-20.
//  Copyright (c) 2014年 XY. All rights reserved.
//

#import "RMUpLoadItem.h"

@implementation XYLoadItem

@end

@interface RMUpLoadItem ()
{
    NSMutableArray *_imageArray;
    NSMutableArray *_audioArray;
}

@end

@implementation RMUpLoadItem

@synthesize imageArray = _imageArray, audioArray = _audioArray;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _imageArray = [[NSMutableArray alloc] init];
        _audioArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addImage:(NSData *)data forCategory:(NSString *)category
{
    XYLoadItem *item = [[XYLoadItem alloc] init];
    [item setFileData:data];
    [item setCategory:category];
    [_imageArray addObject:item];
}

- (void)addImage:(NSData *)data forCategory:(NSString *)category forUrl:(NSString *)url
{
    XYLoadItem *item = [[XYLoadItem alloc] init];
    [item setFileData:data];
    [item setCategory:category];
    [item setAudioTime:url];
    [_imageArray addObject:item];
}

- (void)addImageUrl:(NSString *)url forCategory:(NSString *)category
{
    XYLoadItem *item = [[XYLoadItem alloc] init];
    item.url = url;
    [item setCategory:category];
    [_imageArray addObject:item];
}

- (void)addAutioUrl:(NSString *)url len:(NSString *)length
{
    XYLoadItem *item = [[XYLoadItem alloc] init];
    item.url = url;
    [item setCategory:@"21"];
    [item setAudioTime:length];
    [_audioArray addObject:item];
}

- (void)addAudio:(NSData *)data len:(NSString *)length
{
    if (data) {
        XYLoadItem *item = [[XYLoadItem alloc] init];
        [item setFileData:data];
        [item setCategory:@"21"];
        [item setAudioTime:length];
        [_audioArray addObject:item];
    }
}

- (void)removeAudio
{
    [self removeUpdateItemWithCategory:@"21"];
}

- (void)removeImage
{
    [self removeUpdateItemWithCategory:@"2"];
}

- (BOOL)isOverloadForImage
{
    if ([self.imageArray count] >= 100) {
        return YES;
    }
    return NO;
}

//////////////
- (BOOL)haveImage
{
    return self.imageArray.count > 0 ? YES : NO;
}

- (BOOL)haveAudio
{
    return self.audioArray.count > 0 ? YES : NO;
}

//是否有发送数据
- (BOOL)haveSendData
{
    return ([self haveAudio] | [self haveImage]);
}

- (void)removeUpdateItemWithCategory:(NSString *)category
{
    if ([_audioArray count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category=%@",category];
        if ([category isEqualToString:@"2"]) {
            XYLoadItem *item = [[_imageArray filteredArrayUsingPredicate:predicate] firstObject];
            if (item) {
                [_audioArray removeObject:item];
            }
        } else if ([category isEqualToString:@"21"]) {
            XYLoadItem *item = [[_audioArray filteredArrayUsingPredicate:predicate] firstObject];
            if (item) {
                [_audioArray removeObject:item];
            }
        }
    }
}

@end
