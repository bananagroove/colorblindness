//
//  CBColorInfoUIView.m
//  colorblind
//
//  Created by Fábio Lima on 6/13/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "CBColorInfoUIView.h"
#import "UICBFonts.h"
#import "AppDelegate.h"

@implementation CBColorInfoUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        
        //Setup Color Name Label
        CGRect imageNameFrame = CGRectMake(0,
                                           frame.size.height - (frame.size.height/2 - 15),
                                           frame.size.width,
                                           32);
        colorNameImageView = [[UICBElementView alloc] initWithFrame:imageNameFrame imageNamed:@"name-colorful-black" andOverlay:FALSE];
        [self addSubview:colorNameImageView];
        
        //Setup Color Code
        CGRect imageCodeFrame = CGRectMake(frame.size.width / 2 - 20,
                                           30,
                                           40,
                                           40);
        colorSymbolImageView = [[UICBElementView alloc] initWithFrame:imageCodeFrame imageNamed:@"colorful-black" andOverlay:FALSE];
        [self addSubview:colorSymbolImageView];
        
        //Config Left Button
        leftButton =[UIButton buttonWithType: UIButtonTypeCustom];
        [leftButton setBackgroundImage: [UIImage imageNamed: @"button_menu.png"] forState: UIControlStateNormal];
        [leftButton addTarget: self action: @selector(leftButtonHandler:) forControlEvents: UIControlEventTouchDown];
        leftButton.frame = CGRectMake(20, 20, 60, 60);
        [self addSubview:leftButton];
        
        //Config Right Button
        rightButton =[UIButton buttonWithType: UIButtonTypeCustom];
        [rightButton setBackgroundImage: [UIImage imageNamed: @"button_plus.png"] forState: UIControlStateNormal];
        [rightButton addTarget: self action: @selector(rightButtonHandler:) forControlEvents: UIControlEventTouchDown];
        rightButton.frame = CGRectMake(frame.size.width - 80, 20, 60, 60);
        [self addSubview:rightButton];
        
        
    }
    return self;
}

//Left Button Handler
- (void)leftButtonHandler:(id)sender {
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    [objAppDelegate.deckController toggleLeftView];
    
}

//Right Button Handler
- (void)rightButtonHandler:(id)sender {
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    [objAppDelegate.deckController toggleRightView];
    
}

- (NSString*)whatTheCurrentColorStringFromColor:(UIColor*)color {
    
    CGFloat hue;
    CGFloat sat;
    CGFloat lum;
    CGFloat alpha;
    
    //Fill the Variables
    [color getHue:&hue saturation:&sat brightness:&lum alpha:&alpha];
    
    NSString* colorText;
    
    //Convert Hue Value
    hue = 360 * hue;
    
    if(sat < 0.2 || lum < .1) {
		if(lum > 0.70) {
            colorText = @"white";
		} else if(lum < 0.1) {
            colorText = @"black";
		} else {
            colorText = @"grey";
		}
	} else {
		if(hue > 330 || hue < 7) {
            if(lum > .3){
                if(sat < .5){
                    colorText = @"pink";
                } else {
                    colorText = @"red";
                }
            } else {
                colorText = @"bordeaux";
            }
        } else if(hue > 300) {
            if(lum > .5){
                colorText = @"orchid";
            } else {
                colorText = @"violet";
            }
        } else if(hue > 270) {
            if(lum > .5){
                colorText = @"violet";
            } else {
                colorText = @"purple";
            }
		} else if(hue > 160) {
            if(lum > .3){
                if(sat < .5){
                    colorText = @"lightblue";
                } else {
                    colorText = @"blue";
                }
            } else {
                colorText = @"darkblue";
            }
		} else if(hue > 70) {
			if(lum > .3){
                if(sat < .5){
                    colorText = @"lightgreen";
                } else {
                    colorText = @"green";
                }
            } else {
                colorText = @"darkgreen";
            }
		} else if(hue > 40) {
            if(lum > .8){
                if(sat < .5){
                    colorText = @"lightyellow";
                } else {
                    colorText = @"yellow";
                }
            } else if(lum > .5){
                colorText = @"darkyellow";
            } else {
                colorText = @"brown";
            }
		} else /*hue less than 40 and more than 8*/ {
			if(lum > .6){
                if(sat > .5){
                    colorText = @"orange";
                } else {
                    colorText = @"khaki";
                }
            } else {
                colorText = @"brown";
            }
		}
	}
    
    /*
    NSLog(@"Saturação - %f", sat);
    NSLog(@"Luminancia - %f", lum);
    NSLog(@"Hue - %f", hue);
    NSLog(@"Color – %@",colorText);
    */
    
    [self updateColor:colorText];
    
    return colorText;
    
}

//Change Image Name With Image
- (void)updateColor:(NSString*)colorName {
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    
    if(objAppDelegate.booPauseCapture)
        colorName = objAppDelegate.currentColorString;
    
    if( objAppDelegate.booBlindness ){
    
        [colorNameImageView changeImageWithImageNamed:[NSString stringWithFormat:@"name-%@",colorName]];
        [colorSymbolImageView changeImageWithImageNamed:[NSString stringWithFormat:@"%@",colorName]];
        
        //Update Menu Assets
        [leftButton setBackgroundImage: [UIImage imageNamed: @"button_menu_colorblind.png"] forState: UIControlStateNormal];
        [rightButton setBackgroundImage: [UIImage imageNamed: @"button_plus_colorblind.png"] forState: UIControlStateNormal];
    
    } else {
    
        [colorNameImageView changeImageWithImageNamed:[NSString stringWithFormat:@"name-colorful-%@",colorName]];
        [colorSymbolImageView changeImageWithImageNamed:[NSString stringWithFormat:@"colorful-%@",colorName]];
        
        //Update Menu Assets
        if([colorName isEqualToString:@"white"]){
            [leftButton setBackgroundImage: [UIImage imageNamed: @"button_menu_gray.png"] forState: UIControlStateNormal];
            [rightButton setBackgroundImage: [UIImage imageNamed: @"button_plus_gray.png"] forState: UIControlStateNormal];
        } else {
            [leftButton setBackgroundImage: [UIImage imageNamed: @"button_menu.png"] forState: UIControlStateNormal];
            [rightButton setBackgroundImage: [UIImage imageNamed: @"button_plus.png"] forState: UIControlStateNormal];
        }
        
    }
    
    objAppDelegate.currentColorString = colorName;
    
}

- (void)getHueFromColor:(UIColor*)color {
    
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    BOOL success = [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    NSLog(@"success: %i hue: %0.2f, saturation: %0.2f, brightness: %0.2f, alpha: %0.2f", success, hue, saturation, brightness, alpha);
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    
    UIColor *newBackgroundColor = objAppDelegate.booBlindness ? [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1] : backgroundColor;
    objAppDelegate.currentColor = newBackgroundColor;
    
    super.backgroundColor = newBackgroundColor;
    [self whatTheCurrentColorStringFromColor:backgroundColor];
    
}

@end
