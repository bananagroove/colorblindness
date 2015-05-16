//
//  ColorBlindInitViewController.h
//  colorblind
//
//  Created by Fábio Lima on 3/23/13.
//  Copyright (c) 2013 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusCircle.h"
#import "CBCameraUIView.h"

@interface ColorBlindInitViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	
    CBCameraUIView *cameraView;
    FocusCircle *focusCircle;
    
}

@end
