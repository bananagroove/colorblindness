//
//  CBViewController.m
//  colorblind
//
//  Created by Fábio Lima on 6/13/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "CBViewController.h"
#import "AppDelegate.h"
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation CBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    return self;
}

- (void)setupInterface {
    
    focusCircle = [[FocusCircle alloc] initWithFrame:CGRectMake(
                                                                100,
                                                                100,
                                                                136,
                                                                136)];
    
    colorInfo = [[CBColorInfoUIView alloc] initWithFrame:CGRectMake(
                                                                    0,
                                                                    screenRect.size.width,
                                                                    screenRect.size.width,
                                                                    screenRect.size.height - screenRect.size.width)];
    
    [self.view addSubview:focusCircle];
    [self.view addSubview:colorInfo];
    
    //Config Capture Button
    UIButton *captureButton =[UIButton buttonWithType: UIButtonTypeCustom];
    [captureButton setBackgroundImage: [UIImage imageNamed: @"transparent.png"] forState: UIControlStateNormal];
    [captureButton addTarget: self action: @selector(captureButtonHandler:) forControlEvents: UIControlEventTouchUpInside];
    captureButton.frame = focusCircle.frame;
    [self.view addSubview:captureButton];
    
    //Config Bottom Capture Button
    UIButton *bottomCaptureButton =[UIButton buttonWithType: UIButtonTypeCustom];
    [bottomCaptureButton setBackgroundImage: [UIImage imageNamed: @"transparent.png"] forState: UIControlStateNormal];
    [bottomCaptureButton addTarget: self action: @selector(captureButtonHandler:) forControlEvents: UIControlEventTouchUpInside];
    bottomCaptureButton.frame = CGRectMake(80, screenRect.size.height - 150, 160, 150);
    [self.view addSubview:bottomCaptureButton];
    
}

//Capture Button Handler
- (void)captureButtonHandler:(id)sender {
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    objAppDelegate.booPauseCapture = !objAppDelegate.booPauseCapture;
    
}

- (void)initCapture
{
    
    imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, screenRect.size.width, screenRect.size.width*1.3)];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    if (!captureInput) {
        return;
    }
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    
    [captureOutput setVideoSettings:videoSettings];
    captureSession = [[AVCaptureSession alloc] init];
    NSString* preset = 0;
    if (!preset) {
        preset = AVCaptureSessionPresetMedium;
    }
    captureSession.sessionPreset = preset;
    if ([captureSession canAddInput:captureInput]) {
        [captureSession addInput:captureInput];
    }
    if ([captureSession canAddOutput:captureOutput]) {
        [captureSession addOutput:captureOutput];
    }
    
    //handle prevLayer
    if (!previewLayer) {
        previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    }
    
    //if you want to adjust the previewlayer frame, here!
    CGRect viewRect = self.view.bounds;
    viewRect.size.width = screenRect.size.width;
    viewRect.size.height = screenRect.size.width;
    
    previewLayer.frame = viewRect;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //[self.view.layer addSublayer: previewLayer];
    [captureSession startRunning];
    
    //Add Image Holder
    [self.view addSubview:imageHolder];
    
}

- (UIColor*)checkPixelColorFrom:(UIImage *)image atPoint:(CGPoint)point {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * point.x) + point.y) * 4;
    
    UInt8 blue  = data[pixelInfo];
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 red   = data[pixelInfo + 2];
    CFRelease(pixelData);
    
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:255];
    
    return color;
    
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    //NSLog(@"imageFromSampleBuffer: called");
    
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //UIDeviceOrientation *deviceOrientation = [[UIDevice currentDevice] orientation];
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1 orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
        //NSLog(@"Blindness - %i", objAppDelegate.booBlindness);
        
        //Check if capture is paused
        if(objAppDelegate.booPauseCapture){
            if(!objAppDelegate.booBlindness){
                
                [focusCircle setBackgroundColor:objAppDelegate.currentColor];
                [colorInfo setBackgroundColor:objAppDelegate.currentColor];
                
            }
            return;
        }
        
        //Update Image Preview
        if(objAppDelegate.booBlindness){
            [imageHolder setImage:[self convertImageToGrayScale:image]];
        } else {
            [imageHolder setImage:image];
        }
        
        CGPoint capturePoint = CGPointMake(focusCircle.frame.origin.x + + focusCircle.frame.size.width,
                    focusCircle.frame.origin.y + focusCircle.frame.size.height);
        
        UIColor *caughtColor = [self checkPixelColorFrom:image atPoint:capturePoint];
        
        [focusCircle setBackgroundColor:objAppDelegate.booBlindness ? [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1] : caughtColor];
        [colorInfo setBackgroundColor:caughtColor];
        
	});
}

- (UIImage *)convertImageToGrayScale:(UIImage *)image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    
    [self setupInterface];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    screenRect = [[UIScreen mainScreen] bounds];
    
	[self initCapture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
