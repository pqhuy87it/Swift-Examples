//
//  ViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/7/21.
//

#import "ViewController.h"

#import "DetailsViewController.h"

@interface ViewController ()

@property (assign, readwrite) BOOL bFirstTime;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_bFirstTime = YES;
}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (_bFirstTime) {
		_bFirstTime = NO;
		[self showDisclaimer];
	}
}

- (IBAction)showDetailsTapped:(id)sender {
	
	DetailsViewController *vc = [DetailsViewController new];
	[self.navigationController pushViewController:vc animated:YES];
	
}

- (void)showDisclaimer {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please Note"
																   message:@"This is Example Code Only and should not be considered \"Production Ready.\""
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
	
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

@end
