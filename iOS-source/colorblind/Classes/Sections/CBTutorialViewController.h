//
//  TutorialViewController.h
//  foreat
//
//  Created by FabioTNT on 10/19/13.
//  Copyright (c) 2013 DNA Solutions LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTutorialViewController : UIViewController <UIScrollViewDelegate> {
    
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
}

@end
