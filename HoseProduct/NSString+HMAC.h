//
//  NSString+HMAC.h
//  rest
//
//  Created by masonneil on 15/8/28.
//  Copyright (c) 2015年 masonneil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMAC)
// 校验文件是否被篡改，或者生成一个不变的key
-(NSString *) HMACWithSecret:(NSString *) secret;
@end
