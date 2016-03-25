#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#import "PrefixHeader.pch"




@interface CommonServicesImageProcessing : NSObject
-(UIImage*) Test:(UIImage*)image;
/*
- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;
- (UIImage *) UIImageFromCVMat: (cv::Mat)cvMat;
- (cv::Mat) mserToMat: (std::vector<cv::Point> *) mser;
- (void) drawMser: (std::vector<cv::Point> *) mser intoImage: (cv::Mat *) image withColor: (cv::Scalar) color;
- (std::vector<cv::Point>) maxMser: (cv::Mat *) gray;
*/

@end