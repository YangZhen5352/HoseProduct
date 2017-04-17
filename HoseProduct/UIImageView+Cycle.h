//
//  UIImageView+Cycle.h
//  Model
//
//  Created by edz on 2017/3/14.
//  Copyright © 2017年 edz. All rights reserved.
/*
 * 用法
 * [self.imageView clipCycleImageData:data
                            borderWidth:20
                            borderColor:[UIColor redColor]];
 */

#import <UIKit/UIKit.h>

#define ImageData GetObjcForKey(@"CycleImageData")

@interface UIImageView (Cycle)

/* 裁切成圆形
 * data:二进制图片
 * width:边框宽度 如果为0则无边框
 * color:边框颜色
 */
- (void)clipCycleImageData:(NSData *)data
               borderWidth:(CGFloat )width
               borderColor:(UIColor *)color;

// 裁切图片
- (UIImage *)clipImage:(UIImage *)image imageoritation:(UIImageOrientation)oritation withRect:(CGRect)rect;

// 压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

@interface UIView (HMExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
#pragma mark----------- < 持久化数据存储 > -------------------
#define U_Def [NSUserDefaults standardUserDefaults]

// Object
#define SetObjcForKey(objc, key) [U_Def setObject:objc forKey:key];\
[U_Def synchronize]
#define GetObjcForKey(key) [U_Def objectForKey:key]

// Bool
#define SetBoolForKey(bool, key) [U_Def setBool:bool forKey:key];\
[U_Def synchronize]
#define GetBoolForKey(key) [U_Def boolForKey:key]

// Double
#define SetDoubleForKey(double, key) [U_Def setDouble:double forKey:key];\
[U_Def synchronize]
#define GetDoubleForKey(key) [U_Def doubleForKey:key]

// Float
#define SetFloatForKey(float, key) [U_Def setFloat:float forKey:key];\
[U_Def synchronize]
#define GetFloatForKey(key) [U_Def floatForKey:key]

// Integer
#define SetIntegerForKey(integer, key) [U_Def setInteger:integer forKey:key];\
[U_Def synchronize]
#define GetIntegerForKey(key) [U_Def integerForKey:key]

// URL
#define SetURLForKey(URLString, key) [U_Def setURL: [NSURL URLWithString: URLString] forKey:key];\
[U_Def synchronize]
#define GetURLForKey(key) [U_Def URLForKey:key]
