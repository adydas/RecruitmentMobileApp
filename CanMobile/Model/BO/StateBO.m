//
//  EventBO.m
//  CanMobile
//
//  Created by Wony Shin on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StateBO.h"

@implementation StateBO
@synthesize stateId, stateName;

-(id) init
{
    if (self == [super init] ) {
        self.stateId = [NSString stringWithString:@""];
        self.stateName = [NSString stringWithString:@""];
    }
    return self;
}

@end
