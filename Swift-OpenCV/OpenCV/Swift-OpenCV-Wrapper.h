//
//  Swift-OpenCV-Wrapper.h
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/14/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwiftOpenCVWrapper : NSObject

+(NSString *) openCVVersionString; //get OpenCV Version

+(int) getImageWidth:(UIImage *)image;
+(int) getImageHeight:(UIImage *)image;



@end
