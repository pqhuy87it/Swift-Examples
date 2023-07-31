//
//  MyListRow.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "MyListRow.h"

@implementation MyListRow

- (instancetype)initWithListElement:(ListElement *)e {
	if (self = [super initWithFrame:CGRectZero]) {
		
		// horizontal stack view
		UIStackView *st = [UIStackView new];
		st.spacing = 4;
		st.alignment = UIStackViewAlignmentTop;
		st.distribution = UIStackViewDistributionFillEqually;
		
		UILabel *v = [UILabel new];
		v.numberOfLines = 0;
		v.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightBold];
		v.textColor = [UIColor lightGrayColor];
		v.text = e.title;
		[st addArrangedSubview:v];
		
		v = [UILabel new];
		v.numberOfLines = 0;
		v.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightBold];
		v.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
		v.text = e.data;
		[st addArrangedSubview:v];
		
		st.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:st];
		
		[NSLayoutConstraint activateConstraints:@[
			
			// some vertical "padding"
			[st.topAnchor constraintEqualToAnchor:self.topAnchor constant:12.0],
			[st.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0.0],
			[st.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0.0],
			[st.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12.0],

		]];

	}
	return self;
}

@end
