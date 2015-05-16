#import "UICBLabel.h"
#import "UICBFonts.h"
#import <QuartzCore/QuartzCore.h>

@implementation UICBLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1]];
        [self setFont:[UICBFonts din]];
        
        self.shadowColor = [UIColor whiteColor];
        self.shadowOffset = CGSizeMake(-1,-1);
        
        self.layer.shadowColor = [[UIColor colorWithRed:.8f green:.8f blue:.8f alpha:1] CGColor];
        self.layer.shadowOffset = CGSizeMake(1, 1);
        
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 1;
        
        self.layer.masksToBounds = NO;
        
    }
    
    return self;
}

@end
