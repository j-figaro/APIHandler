//
//  Group.m
//  API_IOS
//
//  Created by Joey Figaro on 4/25/11.
//  Copyright 2011 Overture. All rights reserved.
//

#import "Group.h"


@implementation Group

@synthesize idGroup, name, status;

- (void) printGroup
{
	NSLog(@"Group: %@, %@, %@", idGroup, name, status);
}

@end
