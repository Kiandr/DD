//
//  MserCore.m
//  SmartCamera
//
//  Created by Kian Davoudi-Rad on 2016-03-27.
//  Copyright © 2016 Kian Davoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageUtils.h"
#import <opencv2/opencv.hpp>

@interface ImageUtility : NSObject

- (cv::Mat) cvMatFromUIImage: (UIImage *) image;
- (cv::Mat) cvMatGrayFromUIImage: (UIImage *)image;
- (UIImage *) UIImageFromCVMat: (cv::Mat)cvMat;

@end
