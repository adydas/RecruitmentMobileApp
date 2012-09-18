//
//  EventDetailVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventBO.h"

@interface EventDetailVC : UIViewController


@property (nonatomic, retain) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) EventBO *eventBO;

- (IBAction)editButtonPressed:(id)sender;
- (IBAction)favoriteButtonPressed:(id)sender;

@end
