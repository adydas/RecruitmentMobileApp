//
//  ProfileBO.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileBO.h"

@implementation ProfileBO
@synthesize userName, studentId, firstName, lastName, accountCreated, qRCode;

-(id) init
{
    if (self == [super init] ) {
        self.userName = [NSString stringWithString:@""];
        self.studentId = [NSString stringWithString:@""];
        self.firstName = [NSString stringWithString:@""];
        self.lastName = [NSString stringWithString:@""];
        self.accountCreated = [NSString stringWithString:@""];
        self.qRCode = [NSString stringWithString:@""];
        
    }
    return self;
}

@end
