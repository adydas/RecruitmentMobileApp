//
//  EventBO.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventBO.h"

@implementation EventBO
@synthesize eventId, eventName, eventDescription, eventlocation, eventStartDate, eventEndDate, rsvpDate, eventStartTime, eventEndTime, eventUrl;

-(id) init
{
    if (self == [super init] ) {
        self.eventId = [NSString stringWithString:@""];
        self.eventName = [NSString stringWithString:@""];
        self.eventDescription = [NSString stringWithString:@""];
        self.eventlocation = [NSString stringWithString:@""];
        self.eventStartDate = [NSString stringWithString:@""];
        self.eventEndDate = [NSString stringWithString:@""];
        self.rsvpDate = [NSString stringWithString:@""];
        self.eventStartTime = [NSString stringWithString:@""];
        self.eventEndTime = [NSString stringWithString:@""];
        self.eventUrl = [NSString stringWithString:@""];
        
    }
    return self;
}

@end
