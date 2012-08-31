//
//  ProfileBO.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileBO : NSObject


@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *studentId;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *accountCreated;
@property (nonatomic, retain) NSString *qRCode;

-(id) init;
@end
