//
//  JobBO.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobBO.h"

@implementation JobBO
@synthesize jobId,jobTitle, jobDescription, jobLocation,compDetails, jobCreationDate, employerName, employerDescription, employerIndustry,jobApplyUrl, ApplyByDate, ApplyEndDate,OpportunityType, jobFunction;

-(id) init
{
    if (self == [super init] ) {
        self.jobId = [NSString stringWithString:@""];
        self.jobTitle = [NSString stringWithString:@""];
        self.jobDescription = [NSString stringWithString:@""];
        self.jobLocation = [NSString stringWithString:@""];
        self.compDetails = [NSString stringWithString:@""];
        self.jobCreationDate = [NSString stringWithString:@""];
        self.employerName = [NSString stringWithString:@""];
        self.employerDescription = [NSString stringWithString:@""];
        self.jobApplyUrl = [NSString stringWithString:@""];
        self.ApplyByDate = [NSString stringWithString:@""];
        self.ApplyEndDate = [NSString stringWithString:@""];
        self.jobFunction = [NSString stringWithString:@""];
        self.OpportunityType = [NSString stringWithString:@""];
        self.employerIndustry = [NSString stringWithString:@""];

    }
    return self;
}

@end
