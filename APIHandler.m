//
//  APIHandler.m
//  API
//
//  Created by Joey Figaro on 4/23/11.
//  Copyright 2011 Overture. All rights reserved.
//

#import "APIHandler.h"


static APIHandler *sharedInstance = nil;

@implementation APIHandler

@synthesize responseData, parsedData;
@synthesize groupList;

#pragma mark -
#pragma mark Allocation Methods

+ (APIHandler *)sharedHandler
{
	@synchronized (self) {
		if(sharedInstance == nil) {
			[[self alloc] init];
		}
	}
	
	return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized (self) {
		if (sharedInstance == nil) {
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance;
		}
	}
	
	return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

#pragma mark -
#pragma mark Default Behavior Overrides

- (id)retain
{
	return self;
}

- (void)release
{
	// do nothing.
}

- (id)autorelease
{
	return self;
}

- (NSUInteger)retainCount
{
	return NSUIntegerMax;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"Connection complete!\n");
	[connection release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"Connection received response.\n");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Connection error - %@\n", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	responseData = data;
	SBJsonParser *parser = [SBJsonParser new];
	parsedData = [parser objectWithData:responseData]; 
	[parser release];
	
	if([[parsedData valueForKey:@"status"] isEqualToString:@"success"]) {
		NSString *action = [parsedData valueForKey:@"action"];
		
		if([action isEqualToString:@"groupStatusRequest"]) {
			NSLog(@"[API]: groupStatusRequest satisfied.\n\n");
		
			groupList = [[parsedData objectForKey:@"response"] objectForKey:@"groupList"];
			
			for(NSString *item in groupList) {
				Group *group = [[Group alloc] init];
				group.idGroup = [item valueForKey:@"idGroup"];
				group.name = [item valueForKey:@"name"];
				group.status = [item valueForKey:@"status"];				

				// [group printGroup];
				[groupList addObject:group];
			}
			
			NSLog(@"%@", groupList);
		}
		
		else if([action isEqualToString:@"createGroup"]) {
			NSLog(@"[API]: createGroup satisfied.\n\n");
		}
		
		else if([action isEqualToString:@"deleteGroup"]) {
			NSLog(@"[API]: deleteGroup satisfied.\n\n");
		}
		
		else if([action isEqualToString:@"renameGroup"]) {
			NSLog(@"[API]: renameGroup\n\n");
		}
		
	} else {
		NSLog(@"[API]: Could not satisfy request.");
	}
}

#pragma mark -
#pragma mark APIHandler Methods

- (id)init
{
	@synchronized (self) {
		[super init];

		return self;
	}
}

- (void) sendRequest:(NSString *)method toURL:(NSString *)url email:(NSString *)email password:(NSString *)password action:(NSString *)action
{		
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSString *params = [[NSString alloc] init];
	params = [NSString stringWithFormat:@"email=%@&password=%@&action=%@", email, password, action];
	
	[request setHTTPMethod:method];
	[request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
	[connection start];
}


@end
