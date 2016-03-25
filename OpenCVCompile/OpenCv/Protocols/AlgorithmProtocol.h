//
//  BussinessRepository.h
//  OpenCVCompile
//
//  Created by Kian Davoudi-Rad on 2016-02-03.
//  Copyright © 2016 Kian Davoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelOpenCvAlgorithmsTypes.h"

@protocol AlgorithmProtocol

@required

//-(void) OpenCvAlgorithm: (NSString*) _Altype OpenCvAlMed:(NSString*) _Almethod;
- (void)AITurnOn:(UIImage*)image;

@end
