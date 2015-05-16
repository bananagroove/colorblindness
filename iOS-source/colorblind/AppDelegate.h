//
//  AppDelegate.h
//  colorblind
//
//  Created by Fábio Lima on 3/23/13.
//  Copyright (c) 2013 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConfigViewController.h"
#import "CBPuzzleViewController.h"
#import "CBViewController.h"
#import "CBTutorialViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    UINavigationController *navigationController;
    IIViewDeckController *deckController;
    NSString *currentDeviceToken;
    UIColor *currentColor;
    NSString *currentColorString;
    BOOL booBlindness;
    BOOL booPauseCapture;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *currentDeviceToken;
@property (nonatomic, retain) UIColor *currentColor;
@property (nonatomic, retain) NSString *currentColorString;

//Declare View Deck Variables
@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) CBConfigViewController *leftController;
@property (retain, nonatomic) CBPuzzleViewController *rightController;
@property (retain, nonatomic) IIViewDeckController *deckController;

@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) CBViewController *viewController;

@property (nonatomic) BOOL booBlindness;
@property (nonatomic) BOOL booPauseCapture;

@end
