//
//  TutorialViewController.m
//  foreat
//
//  Created by FabioTNT on 10/19/13.
//  Copyright (c) 2013 DNA Solutions LTDA. All rights reserved.
//

#import "CBTutorialViewController.h"
#import "AppDelegate.h"

@interface CBTutorialViewController ()

@end

@implementation CBTutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //Set screen props
        screenRect      = [[UIScreen mainScreen] bounds];
        screenWidth     = screenRect.size.width;
        screenHeight    = screenRect.size.height;
        
    }
    return self;
}

-(void)startButtonWasPressed:(id)sender {
    
    AppDelegate *objAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [objAppDelegate.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UIScrollviewDelegate methods

- (void)changePage:(id)sender {
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
}

- (void)setupPage {
    
    // Setup the scrollview properties
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    scrollView.delegate = self;
    scrollView.canCancelContentTouches = NO;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorWithRed:.38 green:.38 blue:.38 alpha:1];
    
    [self.view addSubview:scrollView];
    
    //Setup Page Control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, screenHeight - 420, 320, 50)];
    //pageControl.center = CGPointMake(320/2, 480-75);
    pageControl.numberOfPages = 4;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    //Hide Page Control
    //[self.view addSubview:pageControl];
    
    CGFloat cx = 0.0;
    
    for (unsigned i = 1; i <= 4; i++) {
        
        UIImage *tutorialImage = [UIImage imageNamed:[NSString stringWithFormat:@"TutorialPage%i.png", i]];
        UIImageView *tutorialImageView = [[UIImageView alloc]initWithImage:tutorialImage];
        tutorialImageView.frame = CGRectMake(cx, 0, 320, 568);
        [self.view addSubview:tutorialImageView];
        
        [scrollView addSubview:tutorialImageView];
        
        if( i == 4 ){
            
            //Attach Enter Button
            UIButton *startAppButton =[UIButton buttonWithType: UIButtonTypeCustom];
            startAppButton.frame = CGRectMake (cx, 0, screenWidth, screenHeight);
            [startAppButton setBackgroundImage: [UIImage imageNamed: @"transparent.png"] forState: UIControlStateNormal];
            [startAppButton addTarget: self action: @selector(startButtonWasPressed:) forControlEvents: UIControlEventTouchUpInside];
            [scrollView addSubview:startAppButton];
            
        }
        
        cx += scrollView.frame.size.width;
        
    }
    
    [scrollView setContentSize:CGSizeMake(cx, scrollView.bounds.size.height)];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    
    // Calculate which page we will land on
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    pageControl.currentPage = page;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Init the scrollview with data and properties
	[self setupPage];
}

- (void)viewDidAppear:(BOOL)animated{
    
    pageControl.currentPage = 0;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
