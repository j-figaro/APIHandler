//
//  Group.h
//  API_IOS
//
//  Created by Joey Figaro on 4/25/11.
//  Copyright 2011 Overture. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Group : NSObject 
{
	NSString *idGroup;
	NSString *name;
	NSString *status;
}

- (void) printGroup;

@property (retain) NSString *idGroup;
@property (retain) NSString *name;
@property (retain) NSString *status;

@end

