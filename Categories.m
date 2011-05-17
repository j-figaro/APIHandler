//
//  Utilities.m
//  APIRequest
//
//  Created by Joey Figaro on 4/2/11.
//  Copyright 2011 Overture. All rights reserved.
//

#import "Categories.h"

@implementation NSString (Utilities)

+ (NSString *) returnMD5:(NSString *)input
{
	const char *inputStr = [input UTF8String];
	unsigned char result[16];
	CC_MD5(inputStr, strlen(inputStr), result);

	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

@end
