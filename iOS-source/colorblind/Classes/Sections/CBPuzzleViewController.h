//
//  CBPuzzleViewController.h
//  colorblind
//
//  Created by Fabio Nicolau on 9/23/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICBPuzzlePieceView.h"
#import "UICBElementView.h"

@interface CBPuzzleViewController : UIViewController {
    
    CGRect screenRect;
    UICBPuzzlePieceView *bluePiece;
    UICBPuzzlePieceView *yellowPiece;
    UICBPuzzlePieceView *redPiece;
    UICBPuzzlePieceView *blackPiece;
    UICBPuzzlePieceView *whitePiece;
    NSDictionary *mixesDictionary;
    NSDictionary *colorsDictionary;
    NSTimer *resetTimer;
    
    UIImageView *draggingView;
    
    UICBElementView* footer;
    
    BOOL inited;
    
    NSArray *piecesArray;
    
}

- (void)onLongPressHandler:(UILongPressGestureRecognizer*)sender;

@end
