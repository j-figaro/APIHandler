//
//  Utilities.h
//  APIRequest
//
//  Created by Joey Figaro on 4/2/11.
//  Copyright 2011 Overture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Utilities) 

+ (NSString *) returnMD5:(NSString *)input;

@end
