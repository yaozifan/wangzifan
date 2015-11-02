//
//  AFNateWorking.h
//  练习
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNateWorking;
@interface AFNateWorking : NSObject
//使用第三方框架，但不使用管理者
+(void)afNetWorking:(NSString*)urlString
             params:(id)params
              metod:(NSString*)metod
    completionBlock:(void (^)(id completion))completionBlock
         errorBlock:(void(^)(NSError *error))errorBlock;
//使用管理者，不上传图片的方法
+(void)afRequestData:(NSString*)urlString
          HTTPMethod:(NSString*)method
              parame:(id)parames
          completion:(void(^)(id completion))completionBlock
          errorBlock:(void(^)(NSError *error))errorBlock;
//使用管理者上传图片的方法
+(void)afRequestData:(NSString*)urlString
                 HTTPMethod:(NSString*)method
                     parame:(id)parames
                       data:(NSMutableDictionary*)datas
                 completion:(void(^)(id completion))completionBlock
                 errorBlock:(void(^)(NSError *error))errorBlock;


@end
