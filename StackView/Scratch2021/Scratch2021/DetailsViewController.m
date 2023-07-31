//
//  DetailsViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "DetailsViewController.h"

#import "MyTopViewController.h"
#import "MyListViewController.h"
#import "MyBottomViewController.h"

@interface DetailsViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIStackView *mainStackView;

@property (strong, nonatomic) MyTopViewController *myTopVC;
@property (strong, nonatomic) MyListViewController *myLVC;
@property (strong, nonatomic) MyListViewController *myLVC1;
@property (strong, nonatomic) MyListViewController *myLVC2;
@property (strong, nonatomic) MyBottomViewController *myBotVC;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// vertical stack view
	//	will hold the child components
	_mainStackView = [UIStackView new];
	_mainStackView.axis = UILayoutConstraintAxisVertical;
	_mainStackView.spacing = 0;
	
	_scrollView = [UIScrollView new];
	
	_mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
	_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	
	// add stack view to scroll view
	[_scrollView addSubview:_mainStackView];
	
	// add scroll view to view
	[self.view addSubview:_scrollView];
	
	// constraints
	UILayoutGuide *g = [self.view safeAreaLayoutGuide];
	UILayoutGuide *cg = _scrollView.contentLayoutGuide;
	UILayoutGuide *fg = _scrollView.frameLayoutGuide;
	
	[NSLayoutConstraint activateConstraints:@[
		
		// constrain scrollView to all 4 sides (safe area)
		[_scrollView.topAnchor constraintEqualToAnchor:g.topAnchor],
		[_scrollView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor],
		[_scrollView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor],
		[_scrollView.bottomAnchor constraintEqualToAnchor:g.bottomAnchor],
		
		// constrain stackView to all 4 sides (scrollView's Content Layout Guide)
		[_mainStackView.topAnchor constraintEqualToAnchor:cg.topAnchor],
		[_mainStackView.leadingAnchor constraintEqualToAnchor:cg.leadingAnchor],
		[_mainStackView.trailingAnchor constraintEqualToAnchor:cg.trailingAnchor],
		[_mainStackView.bottomAnchor constraintEqualToAnchor:cg.bottomAnchor],
		
		// stackView width == scrollView's width (Frame Layout Guide)
		[_mainStackView.widthAnchor constraintEqualToAnchor:fg.widthAnchor],
		
	]];
	
	// instantiate "component" view controllers
	// add as child controllers
	// add child VC views to stackView
	
    _myLVC2 = [MyListViewController new];
    [self addChildViewController:_myLVC2];
    [_mainStackView addArrangedSubview:_myLVC2.view];
    [_myLVC2 didMoveToParentViewController:self];
    
	_myTopVC = [MyTopViewController new];
	[self addChildViewController:_myTopVC];
	[_mainStackView addArrangedSubview:_myTopVC.view];
	[_myTopVC didMoveToParentViewController:self];
	
	_myLVC = [MyListViewController new];
	[self addChildViewController:_myLVC];
	[_mainStackView addArrangedSubview:_myLVC.view];
	[_myLVC didMoveToParentViewController:self];
	
	_myBotVC = [MyBottomViewController new];
	[self addChildViewController:_myBotVC];
	[_mainStackView addArrangedSubview:_myBotVC.view];
	[_myBotVC didMoveToParentViewController:self];
    
    _myLVC1 = [MyListViewController new];
    [self addChildViewController:_myLVC];
    [_mainStackView addArrangedSubview:_myLVC1.view];
    [_myLVC1 didMoveToParentViewController:self];
	
	// so we can see what's the scrollView
	_scrollView.backgroundColor = [UIColor systemYellowColor];
	
}

@end
