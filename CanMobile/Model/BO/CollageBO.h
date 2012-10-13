//
//  EventBO.h
//  CanMobile
//
//  Created by Wony Shin on 10/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollageBO : NSObject
{
  
}

@property (nonatomic, retain) NSString *collageId;
@property (nonatomic, retain) NSString *collageName;
@property (nonatomic, retain) NSString *collageShortName;
@property (nonatomic, retain) NSString *collageType;

- (id) init;
@end
