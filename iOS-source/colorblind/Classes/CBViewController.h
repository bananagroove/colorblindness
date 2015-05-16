//
//  CBViewController.h
//  colorblind
//
//  Created by Fábio Lima on 6/13/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCameraUIView.h"
#import "FocusCircle.h"
#import "CBColorInfoUIView.h"
#import <AVFoundation/AVFoundation.h>

@interface CBViewController : UIViewController <UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate> {

    CBCameraUIView *previewView;
    AVCaptureVideoPreviewLayer *previewLayer;
	AVCaptureVideoDataOutput *videoDataOutput;
    dispatch_queue_t videoDataOutputQueue;
    AVCaptureSession *captureSession;
	AVCaptureStillImageOutput *stillImageOutput;
	UIView *flashView;
    UIImageView *imageHolder;
    CGRect screenRect;
    
    FocusCircle *focusCircle;
    CBColorInfoUIView *colorInfo;
    
    BOOL isUsingFrontFacingCamera;
    
}

@end
