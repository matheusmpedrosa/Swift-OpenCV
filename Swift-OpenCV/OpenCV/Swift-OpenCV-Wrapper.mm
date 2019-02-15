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
    
//    stringstream width;
//    width << imageMat.size().width;
    NSLog(@"width: %d",imageMat.size().width);
    
//    return [NSString stringWithFormat:@"%s", width.str().c_str()];
    return imageMat.size().width;
}

+(int) getImageHeight:(UIImage *)image {
    
    //transformar UIImage para cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
//    stringstream height;
//    height << imageMat.size().height;
    NSLog(@"height: %d",imageMat.size().height);
    
//    return [NSString stringWithFormat:@"%s", height.str().c_str()];
    return imageMat.size().height;
}

@end
