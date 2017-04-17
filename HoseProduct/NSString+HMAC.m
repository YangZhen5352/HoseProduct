//
//  NSString+HMAC.m
//  rest
//
//  Created by masonneil on 15/8/28.
//  Copyright (c) 2015年 masonneil. All rights reserved.
//

#import "NSString+HMAC.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

@implementation NSString (HMAC)

-(NSString *) HMACWithSecret:(NSString *) secret
{
    CCHmacContext    ctx;
    const char       *key = [secret UTF8String];
    const char       *str = [self UTF8String];
    unsigned char    mac[CC_MD5_DIGEST_LENGTH];
    char             hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
    char             *p;
    
    CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen( key ));
    CCHmacUpdate(&ctx, str, strlen(str) );
    CCHmacFinal(&ctx, mac );
    
    p = hexmac;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++ ) {
        snprintf( p, 3, "%02x", mac[ i ] );
        p += 2;
    }
    
    return [NSString stringWithUTF8String:hexmac];
    
//    NSData *out = [NSData dataWithBytes:mac length:CC_MD5_DIGEST_LENGTH];
//    NSString *base64Enc = [out base64Encoding];
//    return base64Enc;
}

@end
