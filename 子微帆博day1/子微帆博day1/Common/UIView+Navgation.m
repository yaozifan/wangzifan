//
//  UIView+Navgation.m
//  子微帆博day1
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "UIView+Navgation.h"

@implementation UIView (Navgation)
- (UIViewController*)viewController
{
    
    UIResponder *    responder = self.nextResponder;
    
    while (responder !=nil)
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)responder;
            
        }
        responder = responder.nextResponder;
        
    }
    return nil;
    
}
@end
