//
//  NetworkController.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetworkController.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "JobBO.h"
#import "JobsVC.h"
#import "EventBO.h"
#import "AFNetworkActivityIndicatorManager.h"



NetworkController *singleton;

@implementation NetworkController

+(NetworkController*)singleton{

        if (singleton == nil) {
            singleton = [[NetworkController alloc] init];
        }
    
	return singleton;
}


/***Method Description***/
//It hits the active jobs url, call a method with the response as parameter that returns jobs Array, it then sends a call back with a bool and the array. Incase of success bool is true and in case of failiure bool is false and array is nil 
- (void) getJobsFromServer : (ConditionCallbackWithArg) callback
{
    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    
    NSURL *url = [NSURL URLWithString:Base_Url];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];
    
    [httpClient setAuthorizationHeaderWithUsername:username 
                                          password:password];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:Active_Jobs_API_Url parameters:nil];
                
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    NSMutableArray *arr = [self getJobsListFromResponse:JSON];
                    callback (REQUEST_SUCCEEDED, arr);
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }

                    NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                }];
                    [httpClient enqueueHTTPRequestOperation:operation];
                [httpClient release];
                break;
        }
    }];
}

/***Method Description***/
//It hits the search jobs url, call a method with the response as parameter that returns jobs Array, it then sends a call back with a bool and the array. Incase of success bool is true and in case of failiure bool is false and array is nil 
-(void)getSearchedJobsFromServer:(NSString*) searchKeyword andCallBack:(ConditionCallbackWithArg)callback
{

    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    NSURL *url = [NSURL URLWithString:Base_Url_QA];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];
    
    [httpClient setAuthorizationHeaderWithUsername:username 
                                          password:password];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];

    NSString *requestPath = [NSString stringWithFormat:Search_Jobs_API_Url, searchKeyword];
    
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:requestPath parameters:nil];
                
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    NSMutableArray *arr = [self getJobsListFromResponse:JSON];
                    callback (REQUEST_SUCCEEDED, arr);
                    NSLog(@"Search jobs got success");
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }

                    NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                    NSLog(@"Response: %d", response.statusCode);
                }];
                [httpClient enqueueHTTPRequestOperation:operation];
                NSLog(@"status code is %d", operation.response.statusCode);
                [httpClient release];
                break;
        }
    }];

}

/***Method Description***/
//It hits the favorite jobs url, call a method with the response as parameter that returns jobs Array, it then sends a call back with a bool and the array. Incase of success bool is true and in case of failiure bool is false and array is nil 

-(void)getFavoriteJobsFromServer:(ConditionCallbackWithArg)callback
{

    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    
    NSURL *url = [NSURL URLWithString:Base_Url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];

    [httpClient setAuthorizationHeaderWithUsername:username 
                                          password:password];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback (NO_INTERNET, nil);
                
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:Active_Favorite_Jobs_API_Url parameters:nil];
                
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    NSMutableArray *arr = [self getJobsListFromResponse:JSON];
                    callback (REQUEST_SUCCEEDED, arr);
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }
               }];
                
                [httpClient enqueueHTTPRequestOperation:operation];
                [httpClient release];
                break;
        }
    }];

}
    
/***Method Description***/
//It hits the active events url, call a method with the response as parameter that returns events Array, it then sends a call back with a bool and the array. Incase of success bool is true and in case of failiure bool is false and array is nil 
-(void)getEventsFromServer:(ConditionCallbackWithArg)callback
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];

    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;

    NSURL *url = [NSURL URLWithString:Base_Url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];
 
    [httpClient setAuthorizationHeaderWithUsername:username 
                                          password:password];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:Active_Events_API_Url parameters:nil];
                
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    NSMutableArray *arr = [self getEventsListFromResponse:JSON];
                    callback (REQUEST_SUCCEEDED, arr);
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }

                    NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                }];
                
                [httpClient enqueueHTTPRequestOperation:operation];
                [httpClient release];
                
                break;
        }
    }];
 
}

/***Method Description***/
//It hits the login url, extracts the user name string from response, it then sends a call back with a bool and the string. In case of success bool is true and in case of failiure bool is false and string is nil 
-(void)loginWithServer : (ConditionCallbackWithArg) callback

{
    __block NSMutableURLRequest *request;
    __block AFHTTPRequestOperation *operation;

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];

    NSURL *url = [NSURL URLWithString:Base_Url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                            stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];    
    httpClient.parameterEncoding = AFJSONParameterEncoding;

    NSString *requestPath = [NSString stringWithFormat:Login_API_Url, username, password];
    
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                break;
            default:
                request = [httpClient requestWithMethod:@"POST" path:requestPath parameters:nil];
                
                [request setHTTPBody:nil];
                
                operation = [httpClient HTTPRequestOperationWithRequest:request 
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
                    {
                        NSString *strResp = [[NSString alloc] initWithData:responseObject encoding:NSStringEncodingConversionAllowLossy];
                        
                        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                        
                        callback (REQUEST_SUCCEEDED, strResp);   
                    }
                             
                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                            if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                                callback (ERROR_OCCURED, nil);
                            }
                            else
                            {
                                callback (REQUEST_FAILED, nil);
                            }
                                                                                                       
                    }];
                [httpClient enqueueHTTPRequestOperation:operation];
                [httpClient release];
               break;
        }
    }];
}

/***Method Description***/
//It hits the QR Code url, extracts the image from response, it then sends a call back with a bool and the image. In case of success bool is true and in case of failiure bool is false and image is nil 
-(void)getQRCodeFromServer:(ConditionCallbackWithArg)callback
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    

    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;

    
    NSURL *url = [NSURL URLWithString:Base_Url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];
    
    [httpClient setAuthorizationHeaderWithUsername:username 
                                          password:password];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:QR_Code_API_Url parameters:nil];
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    NSLog(@"%@",NSStringFromClass([JSON class]));
                    //        NSMutableArray *arr = [self getQRCodeFromResponse:JSON];
                    callback (REQUEST_SUCCEEDED, JSON);
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }

                    NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                }];
                
                [httpClient enqueueHTTPRequestOperation:operation];
                [httpClient release];
                break;
        }
    }];
}

/***Method Description***/
//It hits the login url, extracts the user name string from response, it then sends a call back with a bool and the string. In case of success bool is true and in case of failiure bool is false and string is nil 
-(void)getFirstNameAndLastNameFromServer:(ConditionCallbackWithArg)callback
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    
    __block NSMutableURLRequest *request;
    __block AFJSONRequestOperation *operation;

    
    NSURL *url = [NSURL URLWithString:Base_Url_QA];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:User_Name_Key_For_User_Defaults];
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:Password_Key_For_User_Defaults];
    NSString *requestPath = [NSString stringWithFormat:Login_API_Url, username, password];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                callback(NO_INTERNET, nil);
                
                break;
            default:
                request = [httpClient requestWithMethod:@"GET" path:requestPath parameters:nil];
                operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    
                    NSLog(@"%@",NSStringFromClass([JSON class]));
                    NSString *userName = [JSON objectForKey:User_First_And_Last_Name]; 
                    callback (REQUEST_SUCCEEDED, userName);
                    
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                    if (operation.response.statusCode == 404 || operation.response.statusCode == 500) {
                        callback (ERROR_OCCURED, nil);
                    }
                    else
                    {
                        callback (REQUEST_FAILED, nil);
                    }
                    NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                }];
                
                [httpClient enqueueHTTPRequestOperation:operation];

                break;
        }
        
    }];
    [httpClient release];
   
}

/***Method Description***/
//It takes NSDictionary, extracts values from its keys and returns array of jobs  
-(NSMutableArray*) getJobsListFromResponse: (NSDictionary*)json

{
    NSMutableArray *jobsArray = [NSMutableArray array];
    
    for(id key in json){
           
            NSDictionary *objDic = [json objectForKey:key];
        NSLog(@"%@",key);
            JobBO *jobBO         = [[JobBO alloc] init];
            jobBO.jobId          = [json  valueForKey:key];
            jobBO.jobTitle       = [objDic valueForKey:Job_Title];
            jobBO.jobDescription = [objDic  valueForKey:Job_Description];
            jobBO.employerName   = [objDic  valueForKey:Job_Employer_Name];
        jobBO.jobApplyUrl = [objDic valueForKey: Job_Apply_Url];
        
        [jobsArray addObject:jobBO];
}
    
    return jobsArray;
}

/***Method Description***/
//It takes NSDictionary, extracts values from its keys and returns array of events 
-(NSMutableArray*) getEventsListFromResponse: (NSMutableArray*)json
{
    NSMutableArray *eventsArray = [NSMutableArray array];
    NSLog(@"%@",NSStringFromClass([json class]));
    NSArray *arr = [json valueForKey:Events_List_Key];
    NSLog(@"%d",[arr count]);
    for (int i = 0; i < [arr count]; i++) {
        
        NSDictionary *objDic     = [arr objectAtIndex:i];
        EventBO *eventBO         = [[EventBO alloc] init];
        eventBO.eventId          = [objDic  valueForKey:Event_Id];
        eventBO.eventName        = [objDic valueForKey:Event_Name];
        eventBO.eventDescription = [objDic  valueForKey:Event_Description];
        if (eventBO.eventDescription == (id)[NSNull null]) {
            eventBO.eventDescription = @"";
        }
        eventBO.eventlocation    = [objDic  valueForKey:Event_Location];
        if (eventBO.eventlocation == (id)[NSNull null]) {
            eventBO.eventlocation = @"";
        }
        eventBO.eventUrl         = [objDic valueForKey: Event_Url];
        if (eventBO.eventUrl == (id)[NSNull null]) {
            eventBO.eventUrl = @"";
        }
        eventBO.eventStartDate   = [objDic valueForKey:Event_Start_Date];
        if (eventBO.eventStartDate == (id)[NSNull null]) {
            eventBO.eventStartDate = @"";
        }
        
        [eventsArray addObject:eventBO];
    }
    
    return eventsArray;

}

//-(NSMutableArray*) getQRCodeFromResponse: (NSDictionary*)json
//{
//    NSMutableArray *eventsArray = [NSMutableArray array];
//    NSLog(@"%@",NSStringFromClass([json class]));
//    return eventsArray;
//}


@end
