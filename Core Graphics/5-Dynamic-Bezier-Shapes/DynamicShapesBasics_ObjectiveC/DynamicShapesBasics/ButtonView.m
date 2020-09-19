//
//  ButtonView.m
//  DynamicShapesBasics
//
//  Created by Peter Krajčík on 4/28/14.
//  Copyright (c) 2014 PixelCut. All rights reserved.
//

#import "ButtonView.h"

#import "MyStyleKit.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect: (CGRect)rect
{
	[MyStyleKit drawBubbleButtonWithFrame: self.bounds];
}

@end
