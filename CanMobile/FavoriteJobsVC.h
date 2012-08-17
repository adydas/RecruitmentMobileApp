//
//  FavoriteJobsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteJobsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UILabel *titleLabel;
    UILabel *subTitleLabel;
    UIButton *editButton;
    UIButton *favoriteButton;
    UIButton *detailDisclosureButton;
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableArray *favoriteJobs;

-(IBAction) applyForJobButtonSelected: (id) sender;
-(void) getFavoriteJobsList;
@end

