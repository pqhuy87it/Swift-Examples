//
//  MyBottomViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "MyBottomViewController.h"

@interface MyBottomViewController ()

@end

@implementation MyBottomViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor systemBlueColor];
	
	UILabel *v = [UILabel new];
	v.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
	v.numberOfLines = 0;
	v.font = [UIFont italicSystemFontOfSize:15.0];
	v.text = @"Striking styling, incredible acceleration and handling, exclusivity, relatively inexpensive for a true exotic.\n\nThe McLaren 570S is a brand new model from McLaren, slotting into the bottom of their lineup below the 650S. The car represents a small move towards the mainstream for the bespoke manufacturer of supercars. Everything that's true for other McLarens remains true for the 570S. However, performance is incredible and buyers who decide to use their cars on a race track will be rewarded with extremely fast lap times. McLaren bills the 570S as a true sports car, with less emphasis on comfort and touring and greater emphasis on driver involvement and fun..";
	v.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:v];
	
	UILayoutGuide *g = [self.view safeAreaLayoutGuide];
	
	[NSLayoutConstraint activateConstraints:@[
		
		[v.topAnchor constraintEqualToAnchor:g.topAnchor constant:20.0],
		[v.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[v.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		[v.bottomAnchor constraintEqualToAnchor:g.bottomAnchor constant:-20.0],
		
	]];
}

@end
