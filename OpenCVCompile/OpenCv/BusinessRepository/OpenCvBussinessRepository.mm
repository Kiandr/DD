// This is the controller main logic hello !


#import "PrefixHeader.pch"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <opencv2/opencv.hpp>
#import  "FPS.h"
#import "MLManager.h"


#import "GeometricsProcessing.hpp"
#import "OpenCvBussinessRepository.h"
#import "CommonServicesImageProcessing.hpp"

#import <opencv2/highgui/ios.h>
#import "MSERManager.h"
#import "MLManager.h"
#import "ImageUtils.h"
#import "GeometryUtil.h"


@implementation OpenCvBussinessRepository



- (id) init
{
    self = [super init];
    if (self) {
        _imageProc = [[CommonServicesImageProcessing alloc]init];
        
        
    }
    return self;
}


// This is the bussiness repository
- (UIImage*)AITurnOn:(UIImage*)image{
    
    
    // Initalization of all Local Vaiables
    cv::Mat gray;
    cv::Mat inputImage;
    
    
    // Info:
    // from OpenCv 3you can directly:
    // UIImage* MatToUIImage(const cv::Mat& image);
    // void UIImageToMat(const UIImage* image, cv::Mat& m, bool alphaExist = false);
    UIImageToMat( image,  inputImage, false);
    
    // Cunstroctin a gray 2-D array
    cv::cvtColor( inputImage, gray, CV_BGRA2GRAY );
    
    
    // Calling to MSER Manager /*This manager layer is unknown to me*/
    std::vector<std::vector<cv::Point>> msers;
    [[MSERManager sharedInstance] detectRegions: gray intoVector: msers];
    
    // Related to MSER Manager, sounds to be the threshhold. UNKNONW!
    
    std::vector<cv::Point> *bestMser = nil;
    double bestPoint = 10.0;
    
    // UNKNONW, most likely searchng into the 2-D array
    
    std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser)
                  {
                      MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
                      
                      if(feature != nil)
                      {
                          if([[MLManager sharedInstance] isToptalLogo: feature] )
                          {
                              double tmp = [[MLManager sharedInstance] distance: feature ];
                              if ( bestPoint > tmp ) {
                                  bestPoint = tmp;
                                  bestMser = &mser;
                              }
                              
                              //[ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
                          }
                          else
                          {
                              //NSLog(@"%@", [feature toString]);
                              //[ImageUtils drawMser: &mser intoImage: &image withColor: RED];
                          }
                      }
                      else
                      {
                          //[ImageUtils drawMser: &mser intoImage: &image withColor: BLUE];
                      }
                  });
    
    if (bestMser)
    {
        NSLog(@"minDist: %f", bestPoint);
        
        cv::Rect bound = cv::boundingRect(*bestMser);
        cv::rectangle(inputImage, bound, GREEN, 3);
    }
    
    
    [FPS draw: inputImage];
    
    // END of MSER proof of concept.
    
    // return this image to the user.
    
    image = MatToUIImage(inputImage);
    
    /*
     
     
     std::vector<std::vector<cv::Point>> msers;
     [[MSERManager sharedInstance] detectRegions: gray intoVector: msers];
     if (msers.size() == 0) { return; };
     
     std::vector<cv::Point> *bestMser = nil;
     double bestPoint = 10.0;
     
     std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser)
     {
     MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
     
     if(feature != nil)
     {
     if([[MLManager sharedInstance] isToptalLogo: feature] )
     {
     double tmp = [[MLManager sharedInstance] distance: feature ];
     if ( bestPoint > tmp ) {
     bestPoint = tmp;
     bestMser = &mser;
     }
     
     //[ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
     }
     else
     {
     //NSLog(@"%@", [feature toString]);
     //[ImageUtils drawMser: &mser intoImage: &image withColor: RED];
     }
     }
     else
     {
     //[ImageUtils drawMser: &mser intoImage: &image withColor: BLUE];
     }
     });
     
     if (bestMser)
     {
     NSLog(@"minDist: %f", bestPoint);
     
     cv::Rect bound = cv::boundingRect(*bestMser);
     cv::rectangle(image, bound, GREEN, 3);
     }
     else
     {
     cv::rectangle(image, cv::Rect(0, 0, W, H), RED, 3);
     }
     
     
     [FPS draw: image];
     
     */
    
    return image;
};





@end

