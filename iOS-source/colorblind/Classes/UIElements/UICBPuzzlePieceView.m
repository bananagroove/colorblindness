//
//  UICBPuzzlePieceView.m
//  colorblind
//
//  Created by Fabio Nicolau on 10/19/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "UICBPuzzlePieceView.h"
#import "AppDelegate.h"
#import "CBPuzzleViewController.h"

@implementation UICBPuzzlePieceView

@synthesize gestureViewHandler, pieceColorName;

- (id)initWithFrame:(CGRect)frame withColor:(NSString*)colorName {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        pieceColorName = colorName;
        [self setPieceAssetsWithColor:colorName];
        
        //Setup Interactions
        [self setupPieceInteraction];
        
    }
    
    return self;
}

- (void)resetPieceColor{
    
    [self setPieceAssetsWithColor:pieceColorName];

}

- (void)setPieceAssetsWithColor:(NSString*)colorName {

    colorfulImage       = [UIImage imageNamed:[NSString stringWithFormat:@"puzzle-colorful-%@.png",colorName]];
    colorfulGrayImage   = [UIImage imageNamed:[NSString stringWithFormat:@"puzzle-colorful-gray-%@.png",colorName]];
    colorblindnessImage = [UIImage imageNamed:[NSString stringWithFormat:@"puzzle-%@.png",colorName]];
    
    //Reload Image
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    [self changeStyle:objAppDelegate.booBlindness ? @"colorblindness" : @"colorful"];
    
}

- (void)setupPieceInteraction{
    
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *onLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressHandler:)];
    onLongPress.minimumPressDuration = .1f;
    
    [self addGestureRecognizer:onLongPress];
    
}

- (void)onLongPressHandler:(UILongPressGestureRecognizer*)sender {
    
    //Reset Piece Color
    [self resetPieceColor];
    
    if(gestureViewHandler)
        [(CBPuzzleViewController*)gestureViewHandler onLongPressHandler:sender];
    
}

- (void)changeStyle:(NSString *)styleName {
    
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    
    if([styleName  isEqual: @"colorful"]){
        [objAppDelegate.currentColorString isEqualToString:@"white"] ? [self setImage:colorfulGrayImage]: [self setImage:colorfulImage];
    } else {
        [self setImage:colorblindnessImage];
    }
    
}

-(UIImage *)getRasterizedImageCopy
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
