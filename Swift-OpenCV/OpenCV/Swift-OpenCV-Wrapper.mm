//
//  Swift-OpenCV-Wrapper.m <-- changed to Swift-OpenCV-Wrapper.mm
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/14/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "Swift-OpenCV-Wrapper.h"

@implementation SwiftOpenCVWrapper

+(NSString *) openCVVersionString
{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

@end
