//
//  MserCore.m
//  SmartCamera
//
//  Created by Kian Davoudi-Rad on 2016-03-27.
//  Copyright © 2016 Kian Davoudi. All rights reserved.
//

// Based on the Documentation at http://docs.opencv.org/2.4/modules/features2d/doc/feature_detection_and_description.html

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>
#import "ImageUtility.h"

#import "MserCore.hpp"

@implementation MserCore: NSObject

/*
 Parameters:
 _delta – Compares (sizei - sizei-delta)/sizei-delta
 _min_area – Prune the area which smaller than minArea
 _max_area – Prune the area which bigger than maxArea
 _max_variation – Prune the area have simliar size to its children
 _min_diversity – For color image, trace back to cut off mser with diversity less than min_diversity
 _max_evolution – For color image, the evolution steps
 _area_threshold – For color image, the area threshold to cause re-initialize
 _min_margin – For color image, ignore too small margin
 _edge_blur_size – For color image, the aperture size for edge blur
 */

// Private member has constant values that I dont undrestand why
// This object required initalization of the parameters;
//  MAGIC NUMBERS! BAD BAD!

cv::MserFeatureDetector mserFeatureDetectorAtCoreInstance;

typedef struct {
    int _delta;
    int _min_area;
    int _max_area;
    double _max_variation;
    double _min_diversity;
    int _max_evolution;
    double _area_threshold;
    double _min_margin;
    int _edge_blur_size;
    
} msertThreshhold;


msertThreshhold * InitFeatureDetectorWithDefaultValues(){
    
    msertThreshhold temp;
    temp._delta = 5;
    temp._min_area=60;
    temp._max_area =14400;
    temp._max_variation=0.25;
    temp._min_diversity  =.2;
    temp._max_evolution = 200;
    temp._area_threshold = 1.01;
    temp._min_margin =0.003;
    temp._edge_blur_size =5;
    
    return &temp;
    
};


//void operator()( const Mat& image, vector<vector<Point> >& msers, const Mat& mask ) const;

// Constructor
- (id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

// Constructor with Initializer
-(id)initWithMserTemplate:(UIImage *) inputtemplateImage
{
    self = [super init];
    if (self) {
        
        if (inputtemplateImage!= nil)
        {
            // Extract MSER features form the InputImage
            // 1- Build a MSER object with the initalized values.
            msertThreshhold *_threshholdSetter = InitFeatureDetectorWithDefaultValues();
            mserFeatureDetectorAtCoreInstance = cv::MserFeatureDetector(
                                                                        _threshholdSetter->_delta,
                                                                        _threshholdSetter->_min_area,
                                                                        _threshholdSetter->_max_area,
                                                                        _threshholdSetter->_max_variation,
                                                                        _threshholdSetter->_min_diversity,
                                                                        _threshholdSetter->_max_evolution,
                                                                        _threshholdSetter->_area_threshold,
                                                                        _threshholdSetter->_min_margin,
                                                                        _threshholdSetter->_edge_blur_size
                                                                        );
            // Converts UIImage to cv::Mat object.
            cv::Mat inputImageToMat;
            UIImageToMat(inputtemplateImage,inputImageToMat);
            
            // Build an MSER vector to hold the values correspondant to the figure
            // vector of point sets
            std::vector<std::vector<cv::Point>> points;
            
            // Now since the MserFeatureDetector object that you just initalized with the magic numbers to fill points from the inputtemplateImage
           // mserFeatureDetectorAtCoreInstance(inputImageToMat, points);
            _MserImage = inputtemplateImage;
        }
        
    }
    return self;
}

- (UIImage *) TestTemplateExtractor:(UIImage*)templateImage {
    
    
    
    // Extract MSER features form the InputImage
    // 1- Build a MSER object with the initalized values.
    msertThreshhold *_threshholdSetter = InitFeatureDetectorWithDefaultValues();
    mserFeatureDetectorAtCoreInstance = cv::MserFeatureDetector(
                                                                _threshholdSetter->_delta,
                                                                _threshholdSetter->_min_area,
                                                                _threshholdSetter->_max_area,
                                                                _threshholdSetter->_max_variation,
                                                                _threshholdSetter->_min_diversity,
                                                                _threshholdSetter->_max_evolution,
                                                                _threshholdSetter->_area_threshold,
                                                                _threshholdSetter->_min_margin,
                                                                _threshholdSetter->_edge_blur_size
                                                                );
    
    // apply the template extracdtor and return this new onne
    // Step one: Costructor
    // basic MSER detector
    // this is the image utility that has to be initated as a common parameter in a interface, but the problem is that the OpenCV trhough and exception when it trys to capture the Opencv.cpp in the header.
    // So, as this is a test function, i will initate this object locally, and then have t destroy it, or let ARC manage the memnory. SO, bad for optimiation.
    //ImageUtility * utilImage = [[ImageUtility alloc]init];
    cv::Mat templateMatObject;//= [utilImage cvMatFromUIImage:templateImage];
    UIImageToMat(templateImage,templateMatObject);
    
    //Step two:
    // vector of point sets
    cv::Mat M(2,2, CV_8UC3, cvScalar(0,255,255));
    IplImage* img = cvLoadImage("greatwave.png", 1);
    std::vector<std::vector<cv::Point>> points;
    
    // detect MSER features
    mserFeatureDetectorAtCoreInstance(img, points);
    
    
    
    

    
    UIImage * test = MatToUIImage(M);
    return test;
    
}


// Extract MSER features from a templateImage
- (UIImage*) LearnTemplateImage: (UIImage *)mserImage{
    
    // vector of point sets
    std::vector<std::vector<cv::Point>> points;
    // Build and MAT image to operate MSER on this image.
    cv::Mat inputImageToMat;
    UIImageToMat(mserImage,inputImageToMat, false);
    
    
    
    
    //    mser(image, points);
    
    /*
     
     
     //void UIImageToMat(const UIImage* image, cv::Mat& m,  bool alphaExist = false);
     cv::Mat logo;
     UIImageToMat(mserImage,logo, false);
     
     //get gray image
     cv::Mat gray;
     cvtColor(logo, gray, CV_BGRA2GRAY);
     
     //mser with maximum area is
     std::vector<cv::Point> maxMser = [ImageUtils maxMser: &gray];
     
     //get 4 vertices of the maxMSER minrect
     cv::RotatedRect rect = cv::minAreaRect(maxMser);
     cv::Point2f points[4];
     rect.points(points);
     
     //normalize image
     cv::Mat M = [GeometryUtil getPerspectiveMatrix: points toSize: rect.size];
     cv::Mat normalizedImage = [GeometryUtil normalizeImage: &gray withTranformationMatrix: &M withSize: rect.size.width];
     
     //get maxMser from normalized image
     std::vector<cv::Point> normalizedMser = [ImageUtils maxMser: &normalizedImage];
     
     //remember the template
     self.logoTemplate = [[MSERManager sharedInstance] extractFeature: &normalizedMser];
     
     //store the feature
     [self storeTemplate];
     */
    return mserImage;
};


-(UIImage*) ProcessIncomeImageWithLeanrtTemplateImage :(UIImage*)inputImg {
    // In this class, the OpenCv uses the Template Image and then applies the Feature Detection on the income uiimage and returns the same image with the similatrity
    
    return inputImg;
};



@end