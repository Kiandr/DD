#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface GeometricsProcessing : NSObject



/*
 Return perspective transformation matrix for given points to square with
 origin [0,0] and with size (size.width, size.width)
 */
- (cv::Mat) getPerspectiveMatrix: (cv::Point2f[]) points toSize: (cv::Size2f) size;

/*
 Returns new perspecivly transformed image with given size
 */
- (cv::Mat) normalizeImage: (cv::Mat *) image withTranformationMatrix: (cv::Mat *) M withSize: (float) size;




@end
