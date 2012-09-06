//
//  EventsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsVC.h"

@interface EventsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    UILabel *titleLabel;
    UILabel *subTitleLabel;
    UIButton *detailDisclosureButton;
     UIView *darkView;
    JobsVC *jobsVCObj;
    
    IBOutlet UIActivityIndicatorView *activityView;
}



@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain)   NSMutableArray *events;

- (void) getEventsList;
- (void) initDarkView;

- (IBAction) detailDiscolosureIndicatorSelected: (id) sender;


@end
