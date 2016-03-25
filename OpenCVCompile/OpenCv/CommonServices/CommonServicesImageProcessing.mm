
#include <iostream>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/opencv.hpp>

#import "opencv2/highgui/cap_ios.h"
#import "CommonServicesImageProcessing.hpp"
#import "opencv2/highgui/ios.h"
#include "opencv2/core/core.hpp"


#include "RetroFilter.hpp"

@implementation CommonServicesImageProcessing



const cv::Scalar RED = cv::Scalar(0, 0, 255);
const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);





/*
static UIImage* MatToUIImage(const cv::Mat& m)
{
    CV_Assert(m.depth() == CV_8U);
    NSData *data = [NSData dataWithBytes:m.data length:m.step*m.rows];
    CGColorSpaceRef colorSpace = m.channels() == 1 ?
    CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(m.cols, m.cols, m.elemSize1()*8, m.elemSize()*8,
                                        m.step[0], colorSpace, kCGImageAlphaNoneSkipLast|kCGBitmapByteOrderDefault,
                                        provider, NULL, false, kCGRenderingIntentDefault);
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return finalImage;
}

static void UIImageToMat(const UIImage* image, cv::Mat& m)
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    m.create(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    CGContextRef contextRef = CGBitmapContextCreate(m.data, m.cols, m.rows, 8,
                                                    m.step[0], colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(
*/

#pragma Test Colur Tracking
static cv::Mat getThresholdMat(cv::Mat srcMat)
{
    
    cv::Mat matHSV;
    cv::cvtColor(srcMat, matHSV, CV_BGR2HSV);// Convert the src into an HSV image
    
    cv::Mat thresholdMat;
    // Change cvScalar values in the order of desired H(hue),S(saturation),V(value).
    // cv::inRange(matHSV, cv::Scalar( 40 , 80 , 32 , 0), cv::Scalar( 70 , 255 , 255 , 0), thresholdMat);
    //cv::inRange(matHSV, cv::Scalar(90 , 84 , 69 , 0), cv::Scalar(100 , 255 , 255 , 0), thresholdMat);
    cv::inRange(matHSV, cv::Scalar(20 , 100 , 100 , 0), cv::Scalar(100 , 255 , 255 , 0 ), thresholdMat);
    matHSV.release();
    
    return thresholdMat;
}
static UIImage *detectBalls(UIImage* image)
{

    cv::Mat colorMat;
    UIImageToMat(image, colorMat);
    UIImage *threshhold = [UIImage imageNamed:@"sample.png"];
    cv::Mat thresholdMat;
    UIImageToMat(threshhold, thresholdMat);
    thresholdMat = getThresholdMat(colorMat);

    cv::GaussianBlur(thresholdMat, thresholdMat, cv::Size(9,9), 2);
    cv::Size strel_size;
    strel_size.width = 3;
    strel_size.height = 3;
    // Create an elliptical structuring element
    cv::Mat strel = cv::getStructuringElement(cv::MORPH_ELLIPSE,strel_size);
    // morpholgical smoothing
    cv::morphologyEx(thresholdMat, thresholdMat, cv::MORPH_CLOSE, strel);
    
    
    std::vector<cv::Vec3f> circles;
    /// Apply the Hough Transform to find the circles
    cv::HoughCircles(thresholdMat, circles, CV_HOUGH_GRADIENT, 1, thresholdMat.rows/4, 200, 40, 20, 200);
    // Draw the circles detected
    // get a CGContext with the image
    CGContextRef contextRef =  getContextForImage( image);

    // set line color
    CGContextSetRGBStrokeColor(contextRef, 1.0, 0.0, 0.0, 1);
    // set line width
    CGContextSetLineWidth(contextRef, 5.0);
    CGRect rect;
    
    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        // circle center
        CGContextSetRGBFillColor(contextRef,0.0,0.0,0.0,1);
        rect = CGContextConvertRectToDeviceSpace(contextRef, CGRectMake(cvRound(circles[i][0]),cvRound(circles[i][1]), 8.0, 8.0));
        CGContextAddEllipseInRect(contextRef, rect);
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationLow);
        CGContextDrawPath(contextRef, kCGPathFill);
        // circle outline
        rect = CGContextConvertRectToDeviceSpace(contextRef, CGRectMake(cvRound(circles[i][0]) - radius,cvRound(circles[i][1]) - radius, 2*radius, 2*radius));
        CGContextAddEllipseInRect(contextRef, rect);
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationLow);
        CGContextStrokePath(contextRef);
    }
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(contextRef);
    UIImage* ballImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(contextRef);
    
    return ballImage;
    
}

static CGContextRef getContextForImage(UIImage* image)
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    CGFloat widthStep = image.size.width;
    
    CGContextRef contextRef = CGBitmapContextCreate(NULL,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    widthStep*4,              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    
    return contextRef;
    
}


# pragma Heavy Lifting OpenCV C Style

//Pure C and C++ functions are compiled here.
#ifdef __cplusplus
static UIImage* processWithOpenCV(const UIImage* image)
{
    cv::Mat m, gray;
    UIImageToMat(image, m);
    cv::cvtColor(m, gray, CV_RGBA2GRAY);
    cv::GaussianBlur(gray, gray, cv::Size(5, 5), 1.2, 1.2);
    cv::Canny(gray, gray, 0, 50);
    m = cv::Scalar::all(255);
    m.setTo(cv::Scalar(0, 128, 255, 255), gray);
    return MatToUIImage(m);
}



-(UIImage*)Test:(UIImage*)inputImage{
    UIImage * ReturnedImage;

    
    //      Uncomment to see picture filter
    ReturnedImage = processWithOpenCV(inputImage);
    //      Uncommet to test ball detector
    
   //       ReturnedImage = detectBalls(inputImage);

    return ReturnedImage;
    
};
#endif


- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC1); // 8 bits per component, 1 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

- (UIImage *) UIImageFromCVMat: (cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1)
    {
        colorSpace = CGColorSpaceCreateDeviceGray();
    }
    else
    {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,//bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

- (cv::Mat) mserToMat: (std::vector<cv::Point> *) mser
{
    int minX = std::min_element(mser->begin(), mser->end(), [] (cv::Point &p1, cv::Point &p2) { return p1.x < p2.x; })[0].x;
    int minY = std::min_element(mser->begin(), mser->end(), [] (cv::Point &p1, cv::Point &p2) { return p1.y < p2.y; })[0].y;
    int maxX = std::max_element(mser->begin(), mser->end(), [] (cv::Point &p1, cv::Point &p2) { return p1.x < p2.x; })[0].x;
    int maxY = std::max_element(mser->begin(), mser->end(), [] (cv::Point &p1, cv::Point &p2) { return p1.y < p2.y; })[0].y;
    
    cv::Mat color(maxY - minY, maxX - minX, CV_8UC3);
    
    std::for_each(mser->begin(), mser->end(), [&] (cv::Point &p)
                  {
                      cv::Point newPoint = cv::Point(p.x - minX, p.y - minY);
                      cv::line(color, newPoint, newPoint, WHITE);
                  });
    cv::Mat gray;
    cvtColor(color, gray, CV_BGR2GRAY);
    
    return gray;
}

- (void) drawMser: (std::vector<cv::Point> *) mser intoImage: (cv::Mat *) image withColor: (cv::Scalar) color
{
    std::for_each(mser->begin(), mser->end(), [&](cv::Point &p) {
        cv::line(*image, p, p, color);
    });
}

- (std::vector<cv::Point>) maxMser: (cv::Mat *) gray
{
    std::vector<std::vector<cv::Point>> msers;
  //  [[MSERManager sharedInstance] detectRegions: *gray intoVector: msers];
    
    if (msers.size() == 0) return std::vector<cv::Point>();
    
    std::vector<cv::Point> mser =
    std::max_element(msers.begin(), msers.end(), [] (std::vector<cv::Point> &m1, std::vector<cv::Point> &m2) {
        return m1.size() < m2.size();
    })[0];
    
    return mser;
}

@end
