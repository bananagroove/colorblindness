//
//  CBColorInfoUIView.h
//  colorblind
//
//  Created by Fábio Lima on 6/13/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICBLabel.h"
#import "UICBElementView.h"

@interface CBColorInfoUIView : UIView {

    CGRect screenRect;
    UIButton *leftButton;
    UIButton *rightButton;
    
    UICBElementView *colorNameImageView;
    UICBElementView *colorSymbolImageView;
    
}

@end
