//
//  Swift-OpenCV-Wrapper.m <-- changed to Swift-OpenCV-Wrapper.mm
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/14/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "Swift-OpenCV-Wrapper.h"
#import <opencv2/imgcodecs/ios.h>
#import <stdio.h>
#import <string>

using std::cout;
using std::endl;
using std::stringstream;

@implementation SwiftOpenCVWrapper

+(NSString *) openCVVersionString
{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

+(int) getImageWidth:(UIImage *)image {
    
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    return imageMat.size().width;
}

+(int) getImageHeight:(UIImage *)image {
    
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    return imageMat.size().height;
}

+ (int)getPixelRedValue:(int)width :(int)height :(UIImage *)image {
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    return imageMat.at<cv::Vec3b>(height,width)[0];
}

+ (int)getPixelGreenValue:(int)width :(int)height :(UIImage *)image {
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    return imageMat.at<cv::Vec3b>(height,width)[1];
}

+ (int)getPixelBlueValue:(int)width :(int)height :(UIImage *)image {
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    return imageMat.at<cv::Vec3b>(height,width)[3];
}

@end
