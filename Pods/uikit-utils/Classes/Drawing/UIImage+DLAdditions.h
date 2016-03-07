//
//  UIImage+DLAdditions.h
//  CheckLists
//
//  Created by Marcel Ruegenberg on 25.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (DLAdditions)
// from http://www.icab.de/blog/2010/10/01/scaling-images-and-creating-thumbnails-from-uiviews/
+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 Automatically make the image a stretchable image assuming it should only be stretched horizontally with 1 px in the middle being stretched.
 */
- (UIImage *)horizontallyStretchedImage;

@end
