#import <UIKit/UIKit.h>

@interface UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)compressedImage;
- (UIImage *)compressedImageWithRatio:(CGFloat)ratio
                              quality:(CGFloat)quality;
- (UIImage *)compressedImageWithMaxLength;
- (UIImage *)compressedImageWithMaxLength:(CGFloat)maxLength
                                  quality:(CGFloat)quality;

@end
