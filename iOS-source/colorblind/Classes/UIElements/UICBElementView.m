//
//  UICBElementView.m
//  colorblind
//
//  Created by Fabio Nicolau on 9/27/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "UICBElementView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UICBElementView

- (id)initWithFrame:(CGRect)frame imageNamed:(NSString*)imageName andOverlay:(BOOL)_booOverlay {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        booOverlay = _booOverlay;
        elementImage = [UIImage imageNamed:imageName];
        
        if(booOverlay){
            self.backgroundColor = [UIColor colorWithRed:.7f green:.7f blue:.7f alpha:.7f];
            [self changeImageWithImageNamed:imageName];
        } else {
            elementImageView = [[UIImageView alloc] initWithImage:elementImage];
            [self addSubview:elementImageView];
        }
        
    }
    
    return self;
}

-(void)changeImageWithImageNamed:(NSString *)imageName {
    
    UIImage *_maskingImage = [UIImage imageNamed:imageName];
    elementImageView.image = _maskingImage;
    
    if(booOverlay){
        CALayer *_maskingLayer = [CALayer layer];
        _maskingLayer.frame = self.bounds;
        [_maskingLayer setContents:(id)[_maskingImage CGImage]];
        [self.layer setMask:_maskingLayer];
        
        [self setNeedsDisplay];
    }
    
}

- (void) changeOverlayColor:(UIColor *)newColor {
    
    self.backgroundColor = newColor;
    
}

@end
