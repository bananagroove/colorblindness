//
//  ColorBlindInitViewController.m
//  colorblind
//
//  Created by Fábio Lima on 3/23/13.
//  Copyright (c) 2013 Banana Groove Studios. All rights reserved.
//

#import "ColorBlindInitViewController.h"

@interface ColorBlindInitViewController ()

@end

@implementation ColorBlindInitViewController

- (id)init {

    self = [super init];
    if (self) {
        NSLog(@"Inited");
        
        cameraView = [[CBCameraUIView alloc] initWithFrame:CGRectMake(
                                                                      100,
                                                                      100,
                                                                      300,
                                                                      300)];
        
        focusCircle = [[FocusCircle alloc] initWithFrame:CGRectMake(
                                                                    100,
                                                                    100,
                                                                    136,
                                                                    136)];
        
        [self.view addSubview:cameraView];
        [self.view addSubview:focusCircle];
        
    }
    
    return self;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    CGImageRef ref = [image CGImage];
	size_t bpp = CGImageGetBitsPerPixel(ref);
	size_t depth = CGImageGetBitsPerComponent(ref);
    size_t w = CGImageGetWidth(ref);
	CGDataProviderRef refProvider = CGImageGetDataProvider(ref);
	CFDataRef refdata = CGDataProviderCopyData(refProvider);
	const UInt8 * data = CFDataGetBytePtr(refdata);
    
	int posX = 800-5;
	int posY = 600-5;
	float accR = 0;
	float accG = 0;
	float accB = 0;
	float accA = 0;
	float hue = 0;
	float sat;
	float lum;
	
	int startpos = (posX + posY * w) * (bpp/depth);
	for(int i = 0; i < 10; i++) {
		for(int j = 0; j < 10; j++) {
			int pos = startpos + i*w*(bpp/depth) + j*(bpp/depth);
			accA += data[pos+3];
			accR += data[pos+2];
			accG += data[pos+1];
			accB += data[pos+0];
		}
	}
	accR /= 25500;
	accG /= 25500;
	accB /= 25500;
	accA /= 25500;
	
	float max = 0;
	float min = 2;
	
	if(accR >= max) max = accR;
	if(accG >= max) max = accG;
	if(accB >= max) max = accB;
	if(accR <= min) min = accR;
	if(accG <= min) min = accG;
	if(accB <= min) min = accB;
	
	lum = 0.5 * (min+max);
	
	if(lum > 0.5) {
		sat = (max-min) / (2-2*lum);
	} else {
		sat = (max-min) / (2*lum);
	}
	
	if((accR == accG)&&(accR == accB)&&(accG == accB)) {
		hue = 0;
		sat = 0;
	} else if((accR >= accG)&&(accR >= accB)) {
		hue = 60 * ((accG-accB) / (max-min)) + 360;
		printf("R max-min = %f diff=%f\n",max-min,accG-accB);
	} else if((accG >= accR)&&(accG >= accB)) {
		hue = 60 * ((accB-accR) / (max-min)) + 120;
		printf("G max-min = %f diff=%f\n",max-min,accG-accR);
	} else if((accB >= accR)&&(accB >= accG)) {
		hue = 60 * ((accR-accG) / (max-min)) + 240;
		printf("B max-min = %f diff=%f\n",max-min,accR-accG);
	}
    
	while(hue > 360) hue = hue - 360;
	while(hue < 0) hue = hue + 360;
	
	//printf("w=%d h=%d d=%d\n", w, h, bpp/depth);
	printf("R=%f G=%f B=%f A=%f -> Hue=%f, Sat=%f, Lum=%f\n", accR, accG, accB, accA, hue, sat, lum);
	
	if(sat < 0.2) {
		if(lum > 0.55) {
			printf("BLANC\n");
		} else if(lum < 0.45) {
			printf("NOIR\n");
		} else {
			printf("GRIS\n");
		}
	} else {
		if(hue > 320) {
			printf("ROUGE\n");
		} else if(hue > 290) {
			printf("ROSE\n");
		} else if(hue > 270) {
			printf("VIOLET\n");
		} else if(hue > 190) {
			printf("BLEU\n");
		} else if(hue > 170) {
			printf("CYAN\n");
		} else if(hue > 70) {
			printf("VERT\n");
		} else if(hue > 50) {
			printf("JAUNE\n");
		} else if(hue > 30) {
			printf("ORANGE\n");
		} else {
			printf("ROUGE\n");
		}
	}
    
    //NSLog(@"Image Color %@", [self getPixelColorAtLocation:CGPointMake(100, 100) ofImage:image]);
    
}

- (UIColor*) getPixelColorAtLocation:(CGPoint)point ofImage:(UIImage *)image {
	
    UIColor* color = nil;
	CGImageRef inImage = image.CGImage;
	
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = UIGraphicsGetCurrentContext();
	if (cgctx == NULL) { return nil; /* error */ }
    
    size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}};
    
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);
    
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
		NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
    
	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { free(data); }
    
	return color;
}

- (void)viewDidAppear:(BOOL)animated
{
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
