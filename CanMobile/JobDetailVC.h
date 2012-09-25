//
//  JobDetailVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBO.h"

@interface JobDetailVC : UIViewController


@property (nonatomic, retain) IBOutlet UILabel *jobNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *jobNameDetailedLabel;
@property (nonatomic, retain) IBOutlet UITextView *jobDetailTextView;
@property (nonatomic, retain) JobBO *jobBO;


- (IBAction) jobApplyButtonPressed:(id)sender;
- (IBAction) favoriteButtonPressed:(id)sender;
- (IBAction) onClickNavBackBtn:(id)sender;

@end
