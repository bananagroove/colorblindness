//
//  UICBPuzzlePieceView.h
//  colorblind
//
//  Created by Fabio Nicolau on 10/19/14.
//  Copyright (c) 2014 Banana Groove Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICBPuzzlePieceView : UIImageView {

    NSString *pieceColorName;
    UIImage *colorfulImage;
    UIImage *colorfulGrayImage;
    UIImage *colorblindnessImage;
    UIViewController *gestureViewHandler;

}

@property (nonatomic, retain) NSString *pieceColorName;
@property (nonatomic, retain) UIViewController *gestureViewHandler;

- (id)initWithFrame:(CGRect)frame withColor:(NSString*)colorName;
- (void)changeStyle:(NSString *)styleName;
- (void)setPieceAssetsWithColor:(NSString*)colorName;
- (void)resetPieceColor;
- (UIImage *)getRasterizedImageCopy;

@end
