//
//  AFNateWorking.m
//  练习
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "AFNateWorking.h"
#import "AFNetworking.h"
@implementation AFNateWorking


+(void)afNetWorking:(NSString*)urlString
             params:(id)params
              metod:(NSString*)metod
    completionBlock:(void (^)(id completion))completionBlock
         errorBlock:(void(^)(NSError *error))errorBlock
{
    /*1.构造url
    2.构造请求对象
    3.构造发送对象
    4.发送请求*/
    /*
     请求参数的格式：
     1.JSON:AFJSONRequestSerializer
     2.XML
     3.KEY-VALUE :AFHTTPRequestSerializer
     */
    
    //需要先构造请求参数格式化对象 会根据类型自动拼接给定的格式
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    //使用请求参数格式化对象构造一个请求参数
    NSMutableURLRequest *urlRequest = [request requestWithMethod:metod URLString:urlString parameters:params error:nil];
    
    //构造线程对象
    AFHTTPRequestOperation *operration = [[AFHTTPRequestOperation alloc]initWithRequest:urlRequest];
    
    //设置响应信息的解析方式，默认是json解析
    operration.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //网络请求事件的监听
    [operration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(responseObject);
        //NSLog(@"信息:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误:%@",error);
        errorBlock(error);
    }];
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [queue addOperation:operration];
    
    
}
+(void)afRequestData:(NSString*)urlString
          HTTPMethod:(NSString*)method
              parame:(id)parames
          completion:(void(^)(id completion))completionBlock
          errorBlock:(void(^)(NSError* error))errorBlock
{
    
    //获取 请求 管理对象
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    //构造请求格式化对象//默认是ker=value
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
  
    //设置返回格式化对象//确定返回格式的解析方法，默认就是json
    manger.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    if ([method isEqualToString:@"POST"]) {
        
        [manger POST:urlString parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completionBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
            
        }];
    }
    else if ([method isEqualToString:@"GET"])
    {
        [manger GET:urlString parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completionBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            errorBlock(error);
            
        }];
        
    }
    
    
}
//使用multpart-formdata协议上传文件的方法
//multpart是http协议为web表单新增的上传文件的协议，数据也是放在请求体中，和普通post请求的区别是格式不是key-value
+(void)afRequestData:(NSString*)urlString
          HTTPMethod:(NSString*)method
              parame:(id)parames
                data:(NSMutableDictionary*)datas
          completion:(void(^)(id completion))completionBlock
          errorBlock:(void(^)(NSError *error))errorBlock
{
 
    //获取 请求 管理对象
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //设置返回格式化对象//确定返回格式的解析方法，默认就是json
    manger.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    if ([method isEqualToString:@"POST"]) {
        
    AFHTTPRequestOperation *operation = [manger POST:urlString parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           for (NSString *keyName in datas) {

               NSData *data = datas[keyName];
               //需要上传的数据添加到
               [formData appendPartWithFileData:data name:keyName fileName:keyName mimeType:@"image/jpeg"];
               
           }
           
       }
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
           completionBlock(responseObject);
       }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           errorBlock(error);
           
       }];
       
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            CGFloat progass = totalBytesWritten/(totalBytesExpectedToWrite*1.0);
            
            NSLog(@"%.2f",progass);
        }];
        
    }

    
    
    
    
    
    
    
}



@end
