//
//  FocusCircle.m
//  colorblind
//
//  Created by Fábio Lima on 3/23/13.
//  Copyright (c) 2013 Banana Groove Studios. All rights reserved.
//

#import "FocusCircle.h"
#import <QuartzCore/QuartzCore.h>

@implementation FocusCircle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame imageNamed:@"focus_circle.png" andOverlay:TRUE];
    return self;
}

@end