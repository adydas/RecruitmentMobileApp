//
//  JobBO.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobBO : NSObject
{
    Boolean *jobIsFullTime;
    Boolean *jobIsPaid;
}

@property (nonatomic, retain) NSString *jobId;
@property (nonatomic, retain) NSString *jobTitle;
@property (nonatomic, retain) NSString *jobDescription;
@property (nonatomic, retain) NSString *jobLocation;
@property (nonatomic, retain) NSString *compDetails;
@property (nonatomic, retain) NSString *jobCreationDate;
@property (nonatomic, retain) NSString *employerName;
@property (nonatomic, retain) NSString *employerDescription;
@property (nonatomic, retain) NSString *jobApplyUrl;
@property (nonatomic, retain) NSString *ApplyByDate;
@property (nonatomic, retain) NSString *ApplyEndDate;
@property (nonatomic, retain) NSString *jobFunction;
@property (nonatomic, retain) NSString *OpportunityType;
@property (nonatomic, retain) NSString *employerIndustry;



-(id) init;



@end
