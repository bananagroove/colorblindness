//
//  UICBElementView.h
//  colorblind
//
//  Created by Fabio Nicolau on 9/27/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICBElementView : UIView {

    UIImage *elementImage;
    UIImageView *elementImageView;
    BOOL booOverlay;
    
}

-(id)initWithFrame:(CGRect)frame imageNamed:(NSString*)imageName andOverlay:(BOOL)_booOverlay;
-(void)changeOverlayColor:(UIColor *)newColor;
-(void)changeImageWithImageNamed:(NSString *)imageName;

@end
