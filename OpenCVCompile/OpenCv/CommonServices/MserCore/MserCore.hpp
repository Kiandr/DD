//
//  MserCore.m
//  SmartCamera
//
//  Created by Kian Davoudi-Rad on 2016-03-27.
//  Copyright © 2016 Kian Davoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





@interface MserCore : NSObject

@property(nonatomic, strong) UIImage * ProcessedImage;
@property(nonatomic, strong) UIImage * MserImage;



- (id)initWithMserTemplate:(UIImage *) inputtemplateImage;
- (UIImage*) ProcessIncomeImageWithLeanrtTemplateImage: (UIImage*) inputImage ;
- (UIImage *) TestTemplateExtractor:(UIImage*) templateImage;

@end
