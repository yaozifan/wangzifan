//
//  WeiBoModel.m
//  子微帆博day1
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiBoModel.h"
//#import "RegexKitLite.h"
@implementation WeiBoModel

- (NSDictionary*)attributeMapDictionary
{
    //   @"属性名": @"数据字典的key"
    NSDictionary*mapAtt = @{
                            @"createDate":@"created_at",
                            @"weiboId":@"id",
                            @"text":@"text",
                            @"source":@"source",
                            @"favorited":@"favorited",
                            @"thumbnailImage":@"thumbnail_pic",
                            @"bmiddlelImage":@"bmiddle_pic",
                            @"originalImage":@"original_pic",
                            @"geo":@"geo",
                            @"repostsCount":@"reposts_count",
                            @"commentsCount":@"comments_count",
                            @"weiboIdStr":@"idstr"
                            
                            };
        return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    /*<a href="http://weibo.com/" rel="nofollow">帮主的iPhone</a>
     需要获得 >x<
     */
    //NSLog(@"%@",self.source);
    if (_source != nil) {
        NSString*regist = @">.+<";
        
        NSArray *array = [_source componentsMatchedByRegex:regist];
        if (array.count!=0) {
            NSString*str = array[0];
            //取得字符串中的第2个字符串～倒数第二个
            str = [str substringWithRange:NSMakeRange(1, str.length-2)];
            
            _source = [NSString stringWithFormat:@"来源：%@",str];
        }
        
    }

    //用户信息的解析
    _userModel = [[UserModel alloc] initWithDataDic:dataDic[@"user"]];
       
    //被转发的微博
    NSDictionary*reWeiboDic = dataDic[@"retweeted_status"];
    
    if (reWeiboDic!=nil) {
        //被转发的微博信息
        _reWeiboModel = [[WeiBoModel alloc]initWithDataDic:reWeiboDic];
        //获取原微博用户名
        NSString*name = _reWeiboModel.userModel.name;
        //拼接转发的用户名和转发的内容
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiboModel.text];
    }
    
    //－表情x    
    // [兔子]
    // 1.png
    // 这条微博内容[兔子]lsajldjfla
    // 这条微博内容<image url = '1.png'>lsa
    
    //>>01 找到微博中表示表情的字符串  [兔子] [微笑]
     NSString*regist = @"\\[\\w+\\]";
    NSArray*faceItems = [_text componentsMatchedByRegex:regist];//在收到的内容中查找正则表达式
    //在plist中寻找对应的png
    NSString*configPath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *faceName in faceItems) {
        //faceName=@"[兔子]"  self.chs=@'[兔子]'
        //用谓词过滤
        
        NSString*t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate*predica = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predica];
        
        if (items.count>0) {
            
            NSDictionary*faceDic = items[0];
            //取得图片名字
            NSString *imageName = [faceDic objectForKey:@"png"];
            // <image url = '1.png'>
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];//把self.text中的faceName替换为replaceString
        }
    }
    
}
@end
