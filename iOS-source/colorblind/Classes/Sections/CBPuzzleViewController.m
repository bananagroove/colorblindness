//
//  CBPuzzleViewController.m
//  colorblind
//
//  Created by Fabio Nicolau on 9/23/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import "CBPuzzleViewController.h"
#import "AppDelegate.h"

@interface CBPuzzleViewController ()

@end

@implementation CBPuzzleViewController

- (void)initView{
    
    //self.view.backgroundColor = [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1];
    [self initPieces];
    
    footer = [[UICBElementView alloc] initWithFrame:CGRectMake(0, screenRect.size.height - 60, 320, 21) imageNamed:@"footer-puzzle" andOverlay:TRUE];
    
    //Check Height to add Footer
    if(screenRect.size.height > 480)
        [[self view] addSubview:footer];
    
    //Set Swipe Gesture
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDoMethod)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer: swipeGesture];
    
    mixesDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"green",@"blue-yellow",
                       @"green",@"yellow-blue",
                       @"orange",@"red-yellow",
                       @"orange",@"yellow-red",
                       @"violet",@"red-blue",
                       @"violet",@"blue-red",
                       //
                       @"darkblue",@"blue-black",
                       @"darkblue",@"black-blue",
                       @"darkyellow",@"yellow-black",
                       @"darkyellow",@"black-yellow",
                       @"bordeaux",@"red-black",
                       @"bordeaux",@"black-red",
                       @"lightblue",@"blue-white",
                       @"lightblue",@"white-blue",
                       @"lightyellow",@"yellow-white",
                       @"lightyellow",@"white-yellow",
                       @"pink",@"red-white",
                       @"pink",@"white-red",
                       //
                       @"gray",@"black-white",
                       @"gray",@"white-black",
                       nil];
    
    colorsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                        //First Colors
                        [UIColor colorWithRed:.12f green:.21f blue:.68f alpha:1],@"blue",
                        [UIColor colorWithRed:.95f green:.84f blue:.20f alpha:1],@"yellow",
                        [UIColor colorWithRed:.82f green:.13f blue:.08f alpha:1],@"red",
                        [UIColor colorWithRed:0 green:0 blue:0 alpha:1],@"black",
                        [UIColor colorWithRed:1 green:1 blue:1 alpha:1],@"white",
                        //Secondary Colors
                        [UIColor colorWithRed:0 green:.69f blue:.57f alpha:1],@"green",
                        [UIColor colorWithRed:.93f green:.44f blue:0 alpha:1],@"orange",
                        [UIColor colorWithRed:.59f green:.14f blue:.57f alpha:1],@"purple",
                        [UIColor colorWithRed:.59f green:.14f blue:.57f alpha:1],@"violet",
                        [UIColor colorWithRed:.11f green:.13f blue:.42f alpha:1],@"darkblue",
                        [UIColor colorWithRed:1 green:.79f blue:0 alpha:1],@"darkyellow",
                        [UIColor colorWithRed:.49f green:.14f blue:.17f alpha:1],@"bordeaux",
                        [UIColor colorWithRed:0 green:.54f blue:.81f alpha:1],@"lightblue",
                        [UIColor colorWithRed:.96 green:.95f blue:.48f alpha:1],@"lightyellow",
                        [UIColor colorWithRed:.99f green:.72f blue:.77f alpha:1],@"pink",
                        [UIColor colorWithRed:.81f green:.81f blue:.81f alpha:1],@"gray",
                        nil];
    
    inited = TRUE;
    
}

- (void)swipeToDoMethod{
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [objAppDelegate.deckController toggleRightView];
}

- (void)initPieces{
    
    int width = 160;
    int height = 155;
    
    bluePiece = [[UICBPuzzlePieceView alloc]initWithFrame:CGRectMake(width*0, height*0, width, height) withColor:@"blue"];
    bluePiece.gestureViewHandler = self;
    [self.view addSubview:bluePiece];
    
    yellowPiece = [[UICBPuzzlePieceView alloc]initWithFrame:CGRectMake(width*1, height*0, width, height) withColor:@"yellow"];
    yellowPiece.gestureViewHandler = self;
    [self.view addSubview:yellowPiece];
    
    redPiece = [[UICBPuzzlePieceView alloc]initWithFrame:CGRectMake(width*0, height*1, width, height) withColor:@"red"];
    redPiece.gestureViewHandler = self;
    [self.view addSubview:redPiece];
    
    blackPiece = [[UICBPuzzlePieceView alloc]initWithFrame:CGRectMake(width*1, height*1, width, height) withColor:@"black"];
    blackPiece.gestureViewHandler = self;
    [self.view addSubview:blackPiece];
    
    whitePiece = [[UICBPuzzlePieceView alloc]initWithFrame:CGRectMake(width*0, height*2, width, height) withColor:@"white"];
    whitePiece.gestureViewHandler = self;
    [self.view addSubview:whitePiece];
    
    piecesArray = [[NSArray alloc] initWithObjects:bluePiece, yellowPiece, redPiece, blackPiece, whitePiece, nil];
    
}

- (void)onLongPressHandler:(UILongPressGestureRecognizer*)sender {
    
    UICBPuzzlePieceView* currentPiece = (UICBPuzzlePieceView*)sender.view;
    CGPoint loc = [sender locationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //Set Aplication Background Color
        if(!objAppDelegate.booBlindness){
            objAppDelegate.currentColor = [colorsDictionary objectForKey:currentPiece.pieceColorName];
            objAppDelegate.currentColorString = currentPiece.pieceColorName;
            self.view.backgroundColor = objAppDelegate.currentColor;
            
            //Change Footer Color
            if([objAppDelegate.currentColorString isEqualToString:@"white"]){
                [footer changeOverlayColor:[UIColor colorWithRed:.73 green:.72 blue:.72 alpha:1]];
            } else {
                [footer changeOverlayColor:[UIColor whiteColor]];
            }
        }
        
        //Reset All Pieces Color
        for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
            [puzzlePiece resetPieceColor];
            [puzzlePiece setAlpha:1];
        }
        
        //Reset Counter
        [resetTimer invalidate];
        resetTimer = nil;
        
        //Set the Dragging View
        draggingView = [[UIImageView alloc] initWithImage:[currentPiece getRasterizedImageCopy]];
        [currentPiece setAlpha:.3f];
        
        [self.view addSubview:draggingView];
        
        draggingView.center = loc;
        //draggingView.backgroundColor = [UIColor colorWithRed:.72 green:.72 blue:.72 alpha:.5];
        [self.view bringSubviewToFront:draggingView];
        
        [UIView animateWithDuration:.4f animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
            draggingView.transform = transform;
        }];
        
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        draggingView.center = loc;
        for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
            if([puzzlePiece isEqual:currentPiece])
                continue;
            puzzlePiece.backgroundColor = CGRectContainsRect(draggingView.frame,puzzlePiece.frame) ? [UIColor colorWithRed:.73 green:.73 blue:.73 alpha:.2] : nil;
        }
        //NSLog(@"Hitting - %i", CGRectContainsRect(draggingView.frame,currentPiece.frame));
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        //Get the Mixed Color
        UICBPuzzlePieceView *mixedColor;
        for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
            if(CGRectContainsRect(draggingView.frame,puzzlePiece.frame)){
                mixedColor = puzzlePiece;
                break;
            }
        }
        
        //Change the Mixed Asset
        NSString* mixedColorName = [self getMixedColorWith:mixedColor.pieceColorName and:currentPiece.pieceColorName];
        if(mixedColorName){
            [mixedColor setPieceAssetsWithColor:mixedColorName];
        
            resetTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                          target:self
                                                        selector:@selector(resetMixes)
                                                        userInfo:nil
                                                         repeats:NO];
            //Alpha all Colors
            for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
                if([puzzlePiece isEqual:mixedColor])
                    continue;
                [UIView animateWithDuration:.3f animations:^{
                    [puzzlePiece setAlpha:.3f];
                }];
            }
        } else {
            [UIView animateWithDuration:.3f animations:^{
                [currentPiece setAlpha:1];
            }];
        }
        
        //Remove Dragging View
        [UIView animateWithDuration:.3f animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(.1f, .1f);
            draggingView.transform = transform;
        } completion:^(BOOL finished){
            [draggingView removeFromSuperview];
            draggingView = nil;
        }];
        
        //Clear All Highlights
        for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
            puzzlePiece.backgroundColor = nil;
        }
        
    }
    
}

-(void)resetMixes{
    
    //Clear All Highlights
    for (UICBPuzzlePieceView* puzzlePiece in piecesArray) {
        puzzlePiece.backgroundColor = nil;
        [puzzlePiece resetPieceColor];
        [UIView animateWithDuration:.3f animations:^{
            [puzzlePiece setAlpha:1];
        }];
    }
    
}

-(NSString*)getMixedColorWith:(NSString*)firstColor and:(NSString*)secondColor{
    
    NSString* mixedColorString = [NSString stringWithFormat:@"%@-%@",firstColor,secondColor];
    NSString* mixedColor = [mixesDictionary objectForKey:mixedColorString];
    
    //Check if has mixed color
    if(!mixedColor)
        mixedColor = firstColor;
    
    NSLog(@"Mixed Color: %@",mixedColor);
    
    //Set Object App Delegate
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Set Aplication Background Color
    if(!objAppDelegate.booBlindness){
        objAppDelegate.booPauseCapture = YES;
        
        objAppDelegate.currentColor = [colorsDictionary objectForKey:mixedColor];
        objAppDelegate.currentColorString = mixedColor;
        
        self.view.backgroundColor = objAppDelegate.currentColor;
        
        //Change Footer Color
        if([objAppDelegate.currentColorString isEqualToString:@"white"]){
            [footer changeOverlayColor:[UIColor colorWithRed:.73 green:.72 blue:.72 alpha:1]];
        } else {
            [footer changeOverlayColor:[UIColor whiteColor]];
        }
    }
    
    return mixedColor;
    
}

-(void)changePiecesStyle:(NSString*)style {
    
    for (UICBPuzzlePieceView* currentPiece in piecesArray) {
        [currentPiece changeStyle:style];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {

    if(!inited)
        [self initView];
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Set Object App Delegate
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(objAppDelegate.currentColor)
        self.view.backgroundColor = objAppDelegate.currentColor;
    
    //Change the Puzzle Style
    [self changePiecesStyle:objAppDelegate.booBlindness ? @"colorblindness" : @"colorful"];
    
    //Change Footer Color
    if(objAppDelegate.booBlindness || [objAppDelegate.currentColorString isEqualToString:@"white"]){
        [footer changeOverlayColor:[UIColor colorWithRed:.73 green:.72 blue:.72 alpha:1]];
    } else {
        [footer changeOverlayColor:[UIColor whiteColor]];
    }
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds];
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
