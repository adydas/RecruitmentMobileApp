//
//  NetworkController.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ConditionCallbackWithArg)(int, id);



@interface NetworkController : NSObject
{
    
}

+(NetworkController*)singleton;

- (void) getJobsFromServer:(ConditionCallbackWithArg)callback;
- (void) getSearchedJobsFromServer:(NSString*) searchKeyword andCallBack:(ConditionCallbackWithArg)callback;
- (void) getFavoriteJobsFromServer:(ConditionCallbackWithArg)callback;
- (void) getEventsFromServer:(ConditionCallbackWithArg)callback;
- (void) checkInEvents:(ConditionCallbackWithArg)callback eventID: (NSString *) strEventID;
- (void) getQRCodeFromServer:(ConditionCallbackWithArg)callback;
- (void) getFirstNameAndLastNameFromServer:(ConditionCallbackWithArg)callback;
- (void) loginWithServer:(ConditionCallbackWithArg)callback;
- (void) getStatesFromServer : (ConditionCallbackWithArg) callback;
- (void) getCollagesFromServer : (ConditionCallbackWithArg) callback;

//-(void)getJobDetailsFromServer:(NSString*)jobId: (ConditionCallbackWithArg)callback;


//-(NSMutableArray*) getQRCodeFromResponse: (NSDictionary*)json;
- (NSMutableArray*) getJobsListFromResponse: (NSDictionary*)json;
- (NSMutableArray*) getEventsListFromResponse: (NSMutableArray*)json;
- (NSMutableArray*) getStatesListFromResponse: (NSDictionary*)json;
- (NSMutableArray*) getCollagesListFromResponse: (NSDictionary*)json;
@end
