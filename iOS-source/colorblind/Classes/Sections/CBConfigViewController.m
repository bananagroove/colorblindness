//
//  CBConfigViewController.m
//  colorblind
//
//  Created by Fabio Nicolau on 9/23/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "CBConfigViewController.h"
#import "AppDelegate.h"

@interface CBConfigViewController ()

@end

@implementation CBConfigViewController

- (void)initView {
    
    self.view.backgroundColor = [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1];
    
    placeHolderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"config-colorful.png"]];
    placeHolderView.frame = CGRectMake(0, 0, placeHolderView.frame.size.width, placeHolderView.frame.size.height);
    [self.view addSubview:placeHolderView];
    
    //Config Colorblind Button
    UIButton *colorblindButton =[UIButton buttonWithType: UIButtonTypeCustom];
    [colorblindButton setBackgroundImage: [UIImage imageNamed: @"transparent.png"] forState: UIControlStateNormal];
    [colorblindButton addTarget: self action: @selector(changeSkinHandler:) forControlEvents: UIControlEventTouchDown];
    colorblindButton.frame = CGRectMake(0, 0, screenRect.size.width, 150);
    colorblindButton.tag = 1;
    [self.view addSubview:colorblindButton];
    
    //Config Colorful  Button
    UIButton *colorfulButton =[UIButton buttonWithType: UIButtonTypeCustom];
    [colorfulButton setBackgroundImage: [UIImage imageNamed: @"transparent.png"] forState: UIControlStateNormal];
    [colorfulButton addTarget: self action: @selector(changeSkinHandler:) forControlEvents: UIControlEventTouchDown];
    colorfulButton.frame = CGRectMake(0, 150, screenRect.size.width, 150);
    colorfulButton.tag = 0;
    [self.view addSubview:colorfulButton];
    
    footer = [[UICBElementView alloc] initWithFrame:CGRectMake(0, screenRect.size.height - 64, 320, 21) imageNamed:@"footer-settings" andOverlay:TRUE];
    [[self view] addSubview:footer];
    
    //Set Swipe Gesture
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDoMethod)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer: swipeGesture];
    
}

- (void)swipeToDoMethod{
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [objAppDelegate.deckController toggleLeftView];
}

//Capture Button Handler
- (void)changeSkinHandler:(id)sender {
    
    //Set Object App Delegate
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIButton *currentButton = sender;
    int currentIndex = (int)currentButton.tag;
    
    placeHolderView.image = currentIndex ? [UIImage imageNamed:@"config.png"] : [objAppDelegate.currentColorString isEqualToString:@"white"] ? [UIImage imageNamed:@"config-colorful-gray.png"] : [UIImage imageNamed:@"config-colorful.png"];
    
    if(currentIndex)
        objAppDelegate.currentColor = [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1];
    
    objAppDelegate.booBlindness = currentIndex;
    objAppDelegate.booPauseCapture = FALSE;
    [objAppDelegate.deckController toggleLeftView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Set Object App Delegate
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(objAppDelegate.currentColor)
        self.view.backgroundColor = objAppDelegate.currentColor;
    
    if(!objAppDelegate.booBlindness){
        placeHolderView.image = [objAppDelegate.currentColorString isEqualToString:@"white"] ? [UIImage imageNamed:@"config-colorful-gray.png"] : [UIImage imageNamed:@"config-colorful.png"];
    }
    
    //Change Footer Color
    if(objAppDelegate.booBlindness || [objAppDelegate.currentColorString isEqualToString:@"white"]){
        [footer changeOverlayColor:[UIColor colorWithRed:.73 green:.72 blue:.72 alpha:1]];
    } else {
        [footer changeOverlayColor:[UIColor whiteColor]];
    }
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
