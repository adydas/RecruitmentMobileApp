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
//    UIButton *editButton;
//    UIButton *favoriteButton;
    UIButton *detailDisclosureButton;
     UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
    JobsVC *jobsVCObj;
}



@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain)   NSMutableArray *events;


-(IBAction) detailDiscolosureIndicatorSelected: (id) sender;
//-(IBAction)prevousButtonPressed:(id)sender;
//-(IBAction)nextButtonPressed:(id)sender;
-(void) getEventsList;
-(void)removeDarkView;
-(void)initDarkView;
@end
