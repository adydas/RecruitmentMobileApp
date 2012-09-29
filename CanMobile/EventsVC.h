//
//  EventsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsVC.h"
#import "EventListCell.h"
#import "CheckEventListCell.h"

@interface EventsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    UILabel *titleLabel;
    UILabel *subTitleLabel;
    UIButton *detailDisclosureButton;
     UIView *darkView;
    JobsVC *jobsVCObj;
    
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic) BOOL  m_bHome;

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain)   NSMutableArray *events;
@property (retain, nonatomic) IBOutlet EventListCell *m_eventCell;
@property (retain, nonatomic) IBOutlet CheckEventListCell *m_checkeventCell;
@property (retain, nonatomic) IBOutlet UISegmentedControl *m_segCtrl;
@property (retain, nonatomic) IBOutlet UISearchBar *m_searchBar;
@property (retain, nonatomic) IBOutlet UILabel *m_labelUnavailable;
@property (retain, nonatomic) IBOutlet UIButton *m_btnCheckin;



- (void) getEventsList;
- (void) initDarkView;
- (id)initWithNibNameHome:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bHome: (BOOL) bHome;

- (IBAction) detailDiscolosureIndicatorSelected: (id) sender;
- (IBAction) onSegValueChanged:(id)sender;




@end
