//
//  MyListViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "MyListViewController.h"

#import "SampleData.h"
#import "MyListRow.h"

@interface MyListViewController ()

@property (strong, nonatomic) NSLayoutConstraint *collapsedConstraint;
@property (strong, nonatomic) NSLayoutConstraint *expandedConstraint;

@end

@implementation MyListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor systemGreenColor];

	// vertical stack view to hold the "rows" of data
	UIStackView *rowsStackView = [UIStackView new];
	rowsStackView.axis = UILayoutConstraintAxisVertical;
	rowsStackView.spacing = 0;
	
	BOOL useSeparatorLines = YES;
	
	// let's get some sample data
	NSMutableArray *a = [SampleData sampleData];
	for (ListElement *e in a) {
		MyListRow *v = [[MyListRow alloc] initWithListElement:e];
		[rowsStackView addArrangedSubview:v];
		
		// add separator lines?
		if (useSeparatorLines) {
			UIView *line = [UIView new];
			line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
			[line.heightAnchor constraintEqualToConstant:1.0].active = YES;
			[rowsStackView addArrangedSubview:line];
		}
	}
	
	UILabel *titleLabel = [UILabel new];
	titleLabel.numberOfLines = 0;
	titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
	titleLabel.text = @"Details - tap anywhere to expand/collapse";

	// add a "container" view
	UIView *cView = [UIView new];
	
	// clip the container's subviews
	cView.clipsToBounds = YES;
	
	for (UIView *v in @[titleLabel, cView]) {
		v.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:v];
	}
	
	// add the stackView to the container
	rowsStackView.translatesAutoresizingMaskIntoConstraints = NO;
	[cView addSubview:rowsStackView];
	
	// constraints
	UILayoutGuide *g = [self.view safeAreaLayoutGuide];
	
	// when expanded, we'll use the full height of the stack view
	_expandedConstraint = [cView.bottomAnchor constraintEqualToAnchor:rowsStackView.bottomAnchor];
	
	// when collapsed, we'll use the bottom of the
	//	3rd label in the stack view -- arrangedSubviews[2]
	// or, if we've added separator lines (see MyListRow.m)
	//	use bottom of 2nd separator line
	
	if (useSeparatorLines) {
		UILabel *v = rowsStackView.arrangedSubviews[5];
		_collapsedConstraint = [cView.bottomAnchor constraintEqualToAnchor:v.bottomAnchor];
	} else {
		UILabel *v = rowsStackView.arrangedSubviews[2];
		_collapsedConstraint = [cView.bottomAnchor constraintEqualToAnchor:v.bottomAnchor];
	}
	
	// start collapsed
	_expandedConstraint.priority = UILayoutPriorityDefaultLow;
	_collapsedConstraint.priority = UILayoutPriorityDefaultHigh;
	
	[NSLayoutConstraint activateConstraints:@[
		
		// titleLabel Top / Leading / Trailing
		[titleLabel.topAnchor constraintEqualToAnchor:g.topAnchor constant:20.0],
		[titleLabel.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:12.0],
		[titleLabel.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-12.0],
		
		// container Top==title.bottom / Leading / Trailing / Bottom
		[cView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:8.0],
		[cView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[cView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		[cView.bottomAnchor constraintEqualToAnchor:g.bottomAnchor constant:-20.0],
		
		// stackView Top / Leading / Trailing
		[rowsStackView.topAnchor constraintEqualToAnchor:cView.topAnchor],
		[rowsStackView.leadingAnchor constraintEqualToAnchor:cView.leadingAnchor],
		[rowsStackView.trailingAnchor constraintEqualToAnchor:cView.trailingAnchor],
		
		_expandedConstraint,
		_collapsedConstraint,
		
	]];

	// background colors so we can see frames
	cView.backgroundColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor cyanColor];
	
	// add a tap recognizer
	UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotTap)];
	[self.view addGestureRecognizer:t];
}

- (void) gotTap {
	
	// toggle priority between expanded / collapsed constraints
	if (_expandedConstraint.priority == UILayoutPriorityDefaultHigh) {
		_expandedConstraint.priority = UILayoutPriorityDefaultLow;
		_collapsedConstraint.priority = UILayoutPriorityDefaultHigh;
	} else {
		_collapsedConstraint.priority = UILayoutPriorityDefaultLow;
		_expandedConstraint.priority = UILayoutPriorityDefaultHigh;
	}
	
	// we want to tell UIKit to animate the complete UI
	//	so, we need to get a reference to the "root" view
	UIView *sv = [self.view superview];
	while ([sv superview] != nil) {
		sv = [sv superview];
	}
	
	// animate the change
	[UIView animateWithDuration:0.5 animations:^{
		[sv layoutIfNeeded];
	}];
	
}

@end
