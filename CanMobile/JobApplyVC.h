//
//  JobApplyVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBO.h"

@interface JobApplyVC : UIViewController
{
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) JobBO *jobBO;

@property (retain, nonatomic) IBOutlet UILabel *m_labelJobTitle;
@property (retain, nonatomic) IBOutlet UILabel *m_labelJobDesc;
@property (retain, nonatomic) IBOutlet UILabel *m_labelLocation;
@property (retain, nonatomic) IBOutlet UITextView *m_textCover;


- (IBAction)onClickChooseResumeBtn:(id)sender;
- (IBAction)onClickApplyBtn:(id)sender;
- (IBAction)onClickNavBackBtn:(id)sender;


@end
