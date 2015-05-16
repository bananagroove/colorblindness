//
//  CBConfigViewController.h
//  colorblind
//
//  Created by Fabio Nicolau on 9/23/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICBElementView.h"

@interface CBConfigViewController : UIViewController {

    CGRect screenRect;
    UIImageView *placeHolderView;
    UICBElementView* footer;
    
    BOOL inited;
    
}

@end
