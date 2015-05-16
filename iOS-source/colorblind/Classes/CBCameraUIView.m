//
//  CBCameraViewController.m
//  colorblind
//
//  Created by Fábio Lima on 6/12/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "CBCameraUIView.h"

@interface CBCameraUIView()

@end

@implementation CBCameraUIView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSLog(@"Inited Camera");
        [self setupCameraCapture];
        
    }
    
    return self;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Picture Taked");
}

- (void)setupCameraCapture {
    
    camera = [[UIImagePickerController alloc] init];
    camera.delegate = self;
    camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    /*
    [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [camera setShowsCameraControls:NO];
	//[camera setNavigationBarHidden:YES];
	//[camera setToolbarHidden:YES];
	[camera setAllowsEditing:NO];
	//[camera setWantsFullScreenLayout:YES];
	//[camera setCameraOverlayView:[self view]];
    //[self presentViewController:camera animated:YES completion:nil];
    
    //[camera takePicture];
     */
    
}

- (void)viewDidAppear:(BOOL)animated {

    [self setupCameraCapture];
    
}
@end
