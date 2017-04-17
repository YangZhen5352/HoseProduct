//
//  UIImageView+Cycle.m
//  Model
//
//  Created by edz on 2017/3/14.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "UIImageView+Cycle.h"

@implementation UIImageView (Cycle)
- (void)clipCycleImageData:(NSData *)data
               borderWidth:(CGFloat )width
               borderColor:(UIColor *)color
{
    UIImage *image = [UIImage imageWithData:data];
    CGFloat imageY;
    if (image.size.height > image.size.width) {
        imageY = (image.size.height - image.size.width)/2;
    } else {
        imageY = (image.size.width - image.size.height)/2;
    }
    // 剪切图片
    image = [self clipImage:image imageoritation:UIImageOrientationUp withRect:CGRectMake(0, imageY, image.size.width, image.size.width)];
    
    // 统一压缩成400*400的图片
    image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(400, 400)];
    
    //开启图片的图形上下文
    UIGraphicsBeginImageContext(image.size);
    
    //获取图形上下文
    CGContextRef text = UIGraphicsGetCurrentContext();
    
    //创建圆环路径
    CGPoint center = CGPointMake(image.size.width*0.5, image.size.height*0.5);
    CGFloat radius = image.size.width*0.5-width;
    CGFloat startAngle = 0;
    CGFloat endAngle = M_PI *2;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //将路径添加到上下文中
    CGContextAddPath(text, path.CGPath);
    
    //设置线条宽度 及颜色
    CGContextSetLineWidth(text, width);
    [color setStroke];
    
    //将路径渲染到上下文上(一定要先绘制外圈的圆环,并且渲染, 否则得不到圆环 )
    CGContextStrokePath(text);
    
    
    //绘制圆形图片路径
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius-2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //添加到图形上下文中
    CGContextAddPath(text, path2.CGPath);
    
    //裁剪路径
    CGContextClip(text);
    
    //绘制图片
    [image drawAtPoint:CGPointMake(2, 2)];
    
    //获取图片的图像上下文中的图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片的图形上下文
    UIGraphicsEndImageContext();
    
    //创建视图,将视图添加到View上展示
    self.image = image;
    
    // 暂时没有使用：保存image成PNG格式图片
    SetObjcForKey(UIImagePNGRepresentation(image), @"CycleImageData");
}

#pragma mark - 压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark - 裁剪图片
- (UIImage *)clipImage:(UIImage *)image imageoritation:(UIImageOrientation)oritation withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *clipImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:oritation];
    CGImageRelease(imageRef);
    return clipImage;
}

@end

@implementation UIView (HMExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


@end

