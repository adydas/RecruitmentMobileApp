//
//  EventBO.m
//  CanMobile
//
//  Created by Wony Shin on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CollageBO.h"

@implementation CollageBO
@synthesize collageId, collageName, collageShortName, collageType;

-(id) init
{
    if (self == [super init] ) {
        self.collageId = [NSString stringWithString:@""];
        self.collageName = [NSString stringWithString:@""];
        self.collageShortName = [NSString stringWithString:@""];
        self.collageType = [NSString stringWithString:@""];
    }
    return self;
}

@end
