// This is the controller main logic hello ! 


#import "PrefixHeader.pch"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#import "GeometricsProcessing.hpp"
#import "OpenCvBussinessRepository.h"
#import "CommonServicesImageProcessing.hpp"




@implementation OpenCvBussinessRepository



- (id) init
{
    self = [super init];
    if (self) {
        _imageProc = [[CommonServicesImageProcessing alloc]init];
        
       
    }
    return self;
}








@end

