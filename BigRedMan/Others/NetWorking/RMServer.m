//
//  SYServer.m
//  ShowYu
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 Tangdada. All rights reserved.
//

#import "RMServer.h"
#import "RMUpLoadItem.h"
#import "AFNetworking.h"

@implementation RMServer
@synthesize user;
static RMServer *sharedServer;

+(RMServer *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedServer=[[RMServer alloc]init];

    });

    return sharedServer;
}

#pragma mark --用户
- (void)setCurrentUser : (NSDictionary *)userDic
{
    if (userDic) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userDic"];
        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userDic"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    }

    if (!user) {
        user = [[RMUser alloc]init];
    }
//    user = [RMUser mj_objectWithKeyValues:userDic];
}

#pragma mark --API
/**
 *  新用户注册
 */
- (void)createUser:(NSDictionary *)userInfo success:(void (^)(id JSON))success error:(void (^)(NSError *error))error{

    [self postWithInfo:userInfo url:URL_CREATE_USER success:success error:error];
}
/**
 *  新用户快捷注册
 */
- (void)quickCreateUser:(NSDictionary *)userInfo success:(void (^)(id JSON))success error:(void (^)(NSError *error))error{
   
    [self postWithInfo:userInfo url:URL_QUICK_CREATE_USER success:success error:error];
}





#pragma mark -- private --有加载图片的
- (void)postWithInfo:(id)userInfo url:(NSString *)url success:(void (^)(id JSON))success error:(void (^)(NSError *error))errorBlock
{
 
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    NSMutableArray *animiteArray = [[NSMutableArray alloc]init];

    for(int i=1; i<=9; i++)
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"loading.bundle" ofType:nil];
        NSString *stringImg = [NSString  stringWithFormat:@"%@/%d",path,i];
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:stringImg];
        [animiteArray addObject:image];
    }
    
    

    [SVProgressHUD showImage:[UIImage animatedImageWithImages:animiteArray duration:1] status:nil];
    
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       manager.requestSerializer.timeoutInterval = 10.0f;
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
       [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
       NSString *encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
      [manager POST:encodedUrl parameters:userInfo progress:^(NSProgress * _Nonnull uploadProgress) {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          dispatch_async(dispatch_get_main_queue(), ^{
              
             
              NSString *key =  [encodedUrl MD5Hash];
              
              if (responseObject[@"error_description"]) {
                  
                  [SVProgressHUD showWithStatus:responseObject[@"error_description"]];
                  [SVProgressHUD dismissWithDelay:3];
                  
                  
                  NSDictionary *JSON = [Lockbox dictionaryForKey:key];
                  if (success) {
                      success(JSON);
                  }
                  
              }else{
                  [SVProgressHUD dismiss];
                  [Lockbox setDictionary:responseObject forKey:key];
                  
                  if (success) {
                      success(responseObject);
                  }
              }
              
          });
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
//          if (errorBlock){
//              errorBlock(error);
//          }
          if (error) {
              
              [SVProgressHUD showWithStatus:@"请检查网络设置重试"];
              [SVProgressHUD dismissWithDelay:3];
              
              NSString *key =  [encodedUrl MD5Hash];
              NSDictionary *JSON = [Lockbox dictionaryForKey:key];
              if (success) {
                  success(JSON);
              }
          }

          
      }];
}

- (void)postNoHUDWithInfo:(id)userInfo url:(NSString *)url success:(void (^)(id JSON))success error:(void (^)(NSError *error))errorBlock
{
/*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:encodedUrl parameters:userInfo
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              dispatch_async(dispatch_get_main_queue(), ^
                             {
                                 [SVProgressHUD dismiss];
                                 if ([[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue] == 0) {

                                     success
                                     (responseObject);

                                 }else if ([[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue] == 8){
                                     NSString *message = [[responseObject objectForKey:@"result"] objectForKey:@"message"];
                                     [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow];
                                     //                                     [SVProgressHUD showErrorWithStatus:message];
                                     //                                     [G_App showLoginView];
                                 }else if ([[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue] == 2003){
                                     NSString *message = [[responseObject objectForKey:@"result"] objectForKey:@"message"];
                                     [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow];
//                                     [G_App showLoginView];
                                 }
                                 else{
                                     NSString *message = [[responseObject objectForKey:@"result"] objectForKey:@"message"];
                                     //                                     [SVProgressHUD showErrorWithStatus:message];
                                     [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow];
                                 }

                             });
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              if (errorBlock)
              {
                  errorBlock(error);
              }

          }];
 */
}

#pragma mark -- 其他接口 --
- (void)uploadFile:(NSData *)fileData withInfo:(NSString *)userInfo fileType:(NSString *)type success:(void (^)(id JSON))success
{
    /*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *encodedUrl = [[NSString stringWithFormat:@"%@?%@",URL_FILE_UPLOAD,userInfo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager POST:encodedUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData name:@"name" fileName:[NSString stringWithFormat:@"file.%@",type] mimeType:@"application/octet-stream"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject)  {
        dispatch_async(dispatch_get_main_queue(), ^{
            success(responseObject);
        });
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [SVProgressHUD showImage:nil status:@"该文件因网络超时原因，未能发送成功，请稍后重试"]; //原提示框样式更改,zhouzhichen
        NSLog(@"Error: %@", error);
    }];
     */
}

- (void)uploadImages:(RMUpLoadItem *)item success:(void (^)(id JSON))upLoadSuccess
{
    /*
    __block NSUInteger count = item.imageArray.count + item.audioArray.count;
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    XYLoadItem *dataItem = item.imageArray[0];
    
    NSString *token = @"NO_TOKEN";
    if (user.token) {
        token = user.token;
    }
    
    NSString *string = [NSString stringWithFormat:@"token=%@&platform=%@",token, Platform_IOS];
    
    [[SYServer shareInstance] uploadFile:dataItem.fileData withInfo:string fileType:@"jpg" success:^(id JSON){
        NSNumber *result = [[JSON objectForKey:@"result"] objectForKey:@"code"];
        if([result integerValue] == 0)
        {
            id stringUrl =  [[[JSON objectForKey:@"data"] objectForKey:@"urls"] objectForKey:@"origin"] ;
            if (stringUrl == nil) {
                stringUrl =  [[[JSON objectForKey:@"data"] objectForKey:@"urls"] objectForKey:@"100_100"] ;
            }
            if(stringUrl == nil){
                stringUrl = [[[JSON objectForKey:@"data"] objectForKey:@"urls"] objectForKey:@"50_50"];
            }
            
            if (stringUrl) {
                [images addObject:[NSDictionary dictionaryWithObject:stringUrl forKey:@"url"]];
            }
            
            count --;
            
            if (0 == count)
            {
                NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] init];
                if (images.count > 0)
                {
                    [jsonDic setObject:images forKey:@"images"];
                }
                upLoadSuccess(jsonDic);
            }
        }
    }];
     */
}

@end
