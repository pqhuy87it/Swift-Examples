//
//  MyListRow.h
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import <UIKit/UIKit.h>

#import "ListElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyListRow : UIView

- (instancetype)initWithListElement:(ListElement *)e;

@end

NS_ASSUME_NONNULL_END
