// This is the controller main logic hello !


#import "PrefixHeader.pch"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <opencv2/opencv.hpp>

#import "OpenCvBussinessRepository.h"


//#import "ImageUtility.h"

#import "MserCore.hpp"
#import "ViewController.h"



@implementation OpenCvBussinessRepository



- (id) init
{
    self = [super init];
    if (self) {
        
        _MserCoreEngine = [[MserCore alloc] initWithMserTemplate:[UIImage imageNamed: @"OLogo"]];
        
    }
    return self;
}



// This is the bussiness repository
- (UIImage*)AITurnOn:(UIImage*)image{
    
    
    
    UIImage * test = [_MserCoreEngine TestTemplateExtractor:image];
    
    
    
    
    
    
    
    
/// THese are all the notes that are gonna help me with the development sampling code. 
    
    
    
    //  UIImage * test = [_MserCoreEngine TestTemplateExtractor:[UIImage imageNamed: @"OLogo"]];
    
    /*
    UIImage * test = [[UIImage alloc] init];
    
    dispatch_async (dispatch_get_main_queue(), ^{
    _MserCoreEngine = [[MserCore alloc] initWithMserTemplate:image];
    [_MserCoreEngine ProcessIncomeImageWithLeanrtTemplateImage:image];
    });

    */
    
    // Apply MSER detection
    //
    
    //UIImage * test = [CoreEngin ProcessIncomeImageWithLeanrtTemplateImage:image];
    
    /*
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
    
    // gray shoud be the example picture that custrocts and object in the detector which is bwing used in the extrct Features.
    
    //UIImage *test = [UIImage imageNamed:@"O.png"];
    //UIImage* imageObj = [[UIImage alloc] initWithContentsOfFile:imageName];
    
    
    // Calling to MSER Manager /*This manager layer is unknown to me
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
    */
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
    
    return test;
};





@end

