// This is the controller main logic hello !
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "OpenCvServiceRepository.h"
#import "OpenCvBussinessRepository.h"

@implementation OpenCvServiceRepository : NSObject
- (id) init
{
    self = [super init];
    if (self) {
        // All initializations you needCGContextDrawImage
        // Access to CommonServiceImageProcessing
        _bussinessRepo = [[OpenCvBussinessRepository alloc]init];

    }
    return self;
}


- (UIImage*)AITurnOn:(UIImage*)image{
    return [_bussinessRepo AITurnOn:image];
    
   // do heavy lifting work
    
    
}

@end

