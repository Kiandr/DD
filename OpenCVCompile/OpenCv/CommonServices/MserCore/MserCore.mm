//
//  MserCore.m
//  SmartCamera
//
//  Created by Kian Davoudi-Rad on 2016-03-27.
//  Copyright © 2016 Kian Davoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MserCore.h"

@implementation MserCore: NSObject


// This object required initalization of the parameters;

cv::MserFeatureDetector MserFeatureDetectorAtCoreInstance;


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
            // Extract MSER features form the InputImage
            _MserImage = [self LearnTemplateImage:inputtemplateImage];
    }
    return self;
}

- (UIImage*) LearnTemplateImage: (UIImage *)mserImage{
    // build an MSER template image
    return mserImage;
};


-(UIImage*) ProcessIncomeImageWithLeanrtTemplateImage :(UIImage*)inputImg {
    // In this class, the OpenCv uses the Template Image and then applies the Feature Detection on the income uiimage and returns the same image with the similatrity
   
    return inputImg;
};

@end