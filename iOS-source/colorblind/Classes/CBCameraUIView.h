//
//  CBCameraViewController.h
//  colorblind
//
//  Created by Fábio Lima on 6/12/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCameraUIView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

    UIImagePickerController *camera;
    
}

@end
