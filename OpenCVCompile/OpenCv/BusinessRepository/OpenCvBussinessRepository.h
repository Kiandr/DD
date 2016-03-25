// THis is the header of the open cv controller 
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller for camera interface.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonServicesImageProcessing.hpp"
#include "AlgorithmProtocol.h"



@interface OpenCvBussinessRepository : NSObject<AlgorithmProtocol>



@property CommonServicesImageProcessing* imageProc;
// This is the bussiness repository
- (UIImage*)AITurnOn:(UIImage*)image;



@end


