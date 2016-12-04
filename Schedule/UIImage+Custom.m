#import "UIImage+Custom.h"

@implementation UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color
                              size:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *)compressedImage {
    return [self compressedImageWithRatio:0.5f
                                  quality:0.5f];
}

- (UIImage *)compressedImageWithMaxLength {
    CGFloat maxLength = 100.0f;
    return [self compressedImageWithMaxLength:maxLength
                                      quality:0.75f];
}

- (UIImage *)compressedImageWithMaxLength:(CGFloat)maxLength
                                  quality:(CGFloat)quality {
    CGFloat ratio = 1.0f;
    if (!maxLength) {
        return [self compressedImage];
    }
    
    CGSize imageSize = self.size;
    if (imageSize.width >= imageSize.height) {
        ratio = imageSize.width > maxLength ? maxLength / imageSize.width : 1.0f;
    } else {
        ratio = imageSize.height > maxLength ? maxLength / imageSize.height : 1.0f;
    }
    
    return [self compressedImageWithRatio:ratio
                                  quality:quality];
}

- (UIImage *)compressedImageWithRatio:(CGFloat)ratio
                              quality:(CGFloat)quality {
    UIImage *newImage = self;
    if (quality) {
        NSData *imageData = UIImageJPEGRepresentation(self, quality);
        newImage = [UIImage imageWithData:imageData];
    }
    
    if (ratio < 1.0f) {
        CGSize newSize = CGSizeMake(round(self.size.width * ratio), round(self.size.height * ratio));
        UIGraphicsBeginImageContext(newSize);
        [newImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newImage;
}

@end
