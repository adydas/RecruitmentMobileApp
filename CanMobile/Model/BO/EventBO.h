//
//  EventBO.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventBO : NSObject
{
    NSInteger *resvpCapacity;
    Boolean canRsvp;

}
@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *eventDescription;
@property (nonatomic, retain) NSString *eventlocation;
@property (nonatomic, retain) NSString *eventStartDate;
@property (nonatomic, retain) NSString *eventEndDate;
@property (nonatomic, retain) NSString *rsvpDate;
@property (nonatomic, retain) NSString *eventStartTime;
@property (nonatomic, retain) NSString *eventEndTime;
@property (nonatomic, retain) NSString *eventUrl;

-(id) init;
@end
