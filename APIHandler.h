//
//
//	APIHandler.h
//
//  Created by Joey Figaro on 3/30/11.
//  Copyright 2011 Overture. All rights reserved.	
//
//	Singleton Class for handling API requests and responses.

#import "JSON.h"
#import "Categories.h"
#import "Group.h"


@interface APIHandler : NSObject 
{
	//	Default Class Data
	NSData *responseData;
	NSDictionary *parsedData;
	
	// Bonfire Specific Objects
	NSMutableArray *groupList;
}

#pragma mark -
#pragma mark Singleton Methods
+ (APIHandler *)sharedHandler;

#pragma mark -
#pragma mark Delegate Methods
- (void) connectionDidFinishLoading: (NSURLConnection *)connection;
- (void) connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response;
- (void) connection: (NSURLConnection *)connection didFailWithError: (NSError *)error;
- (void) connection: (NSURLConnection *)connection didReceiveData: (NSData *)data;

#pragma mark -
#pragma mark APIHandler Methods
- (void) sendRequest: (NSString *)method toURL: (NSString *)url email: (NSString *)email password: (NSString *)password action: (NSString *)action;

#pragma mark -
#pragma mark Properties
@property (nonatomic, retain) NSData *responseData;
@property (nonatomic, retain) NSDictionary *parsedData;
@property (nonatomic, retain) NSMutableArray *groupList;


@end
