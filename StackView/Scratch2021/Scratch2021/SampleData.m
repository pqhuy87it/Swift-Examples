//
//  SampleData.m
//  Scratch2021
//
//  Created by Don Mag on 5/8/21.
//

#import "SampleData.h"

@implementation SampleData

+ (NSMutableArray<ListElement *> *)sampleData {
	ListElement *e;
	
	NSMutableArray *a = [NSMutableArray new];
	
	e = [ListElement new];
	e.title = @"MSRP";
	e.data = @"$184,900";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"EPA Clasification";
	e.data = @"Two-Seaters";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Engine";
	e.data = @"Twin Turbo Premium Unleaded V-8 3.8L/232 cu in";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Transmission";
	e.data = @"Auto-Shift Manual w/OD";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Drivetrain";
	e.data = @"Rear Wheel Drive";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Fuel";
	e.data = @"Gasoline";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Seating";
	e.data = @"2";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Horsepower";
	e.data = @"710";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Brakes";
	e.data = @"4-Wheel Disc Brakes";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Front Tire Size";
	e.data = @"P225/35YR19";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"Rear Tire Size";
	e.data = @"P285/35YR20";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"EPA - City MPG";
	e.data = @"16";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"EPA - Highway MPG";
	e.data = @"23";
	[a addObject:e];
	
	e = [ListElement new];
	e.title = @"EPA - Combined MPG";
	e.data = @"19";
	[a addObject:e];
	

	return a;
}

@end
