#import "UICBFonts.h"

@implementation UICBFonts

+(UIFont*)colorAdd{
    
    return [UIFont fontWithName:@"coloradd" size:60];
    
}

+(UIFont*)colorAddWithSize:(int)fontSize {
    
    return[UIFont fontWithName:@"coloradd" size:fontSize];
    
}

+(UIFont*)din{
    
    return [UIFont fontWithName:@"OSP-DIN" size:30];
    
}

+(UIFont*)dinWithSize:(int)fontSize {
    
    return[UIFont fontWithName:@"OSP-DIN" size:fontSize];
    
}

static NSDictionary* codeDictionary = nil;
+ (NSDictionary*)getCodeDictionary {
    
    if (codeDictionary == nil)
        codeDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"",@"logo",
                          @"",@"menu",
                          @"",@"x",
                          @"",@"+",
                          @"",@"-",
                          @"",@"lightBorder",
                          @"",@"square",
                          @"",@"white",
                          @"",@"black",
                          @"",@"top",
                          @"",@"red",
                          @"",@"lightRed",
                          @"",@"darkRed",
                          @"",@"green",
                          @"",@"lightGreen",
                          @"",@"darkGreen",
                          @"",@"blue",
                          @"",@"lightBlue",
                          @"",@"darkBlue",
                          @"",@"yellow",
                          @"",@"lightYellow",
                          @"",@"darkYellow",
                          @"",@"purple",
                          @"",@"lightPurple",
                          @"",@"darkPurple",
                          @"",@"orange",
                          @"",@"lightOrange",
                          @"",@"darkOrange",
                          @"",@"brown",
                          @"",@"lightBrown",
                          @"",@"darkBrown",
                          @"",@"gray",
                          @"",@"lightGray",
                          @"",@"darkGray",
                          nil];
    return codeDictionary;
}

@end
