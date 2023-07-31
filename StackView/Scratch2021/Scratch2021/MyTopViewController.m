//
//  MyTopViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "MyTopViewController.h"

@interface MyTopViewController ()

@end

@implementation MyTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor systemRedColor];
	
	UILabel *v = [UILabel new];
	v.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
	v.numberOfLines = 0;
	v.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
	v.text = @"This is the text in the label in MyTopViewController.\n\nYou might replace this with a horizontal collection view of images, for example.";
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
