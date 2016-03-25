#import <Foundation/Foundation.h>

@interface MSERProcessing : NSObject

@property NSInteger numberOfHoles;
@property double convexHullAreaRate;
@property double minRectAreaRate;
@property double skeletLengthRate;
@property double contourAreaRate;

-(double) distace: (MSERProcessing *) other;

-(NSString *)description;

-(NSString *)toString;

@end
