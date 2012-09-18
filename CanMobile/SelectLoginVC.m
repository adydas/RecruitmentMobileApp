//
//  SelectLoginVC.m
//  CanMobile
//
//  Created by Optiplex790 on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectLoginVC.h"
#import "LoginVC.h"

@interface SelectLoginVC ()

@end

@implementation SelectLoginVC
@synthesize m_viewPicker;
@synthesize m_pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImageView *homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Login_Home_Icon]];
        homeImageView.frame = CGRectMake(-70, -10, 16, 16);
        
        CGRect frame = CGRectMake(-80, -25, 200, 44);
        UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
        [label setBackgroundColor:[UIColor clearColor]];
        label.font = [UIFont boldSystemFontOfSize: 20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:1];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = Login_Navigation_Bar_Title_Text;
        
        UIView *view = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.frame];
        view.backgroundColor = [UIColor yellowColor];
        [view addSubview:homeImageView];
        [view addSubview:label];
        self.navigationItem.titleView = view;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setM_viewPicker:nil];
    [self setM_pickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [m_viewPicker release];
    [m_pickerView release];
    [super dealloc];
}


////////////////////////////////////////////////////////////////////////////////////
//// Picker View Delegate
////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == m_pickerView)
    {
        return 0;
    }
    
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == m_pickerView) {
        return 1;
    }
    
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (pickerView == m_pickerView)
	{
		return nil;
	}
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}

/**
 ** Show Drop Down menu
 **/

- (void) ShowDropdown {
    
    if (m_viewPicker.hidden == NO)
        return;

    // Animation
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 0.7f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:nil];
    
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height - m_viewPicker.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    [m_viewPicker setHidden: NO];
    
	[UIView commitAnimations];
    
}

- (void) HideDropdown {
    if (m_viewPicker.hidden == YES)
        return;
    
    // Animation
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 0.7f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(datepickerAnimationEnded)];
    
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    
	[UIView commitAnimations];
    
}

- (void) datepickerAnimationEnded {
    [m_viewPicker setHidden: YES];
}

#pragma mark - Actions

- (IBAction)onClickChooseStateBtn:(id)sender {
    [self ShowDropdown];
}


- (IBAction)onClickChooseSchoolBtn:(id)sender {
    [self ShowDropdown];
}

- (IBAction)onClickLoginBtn:(id)sender {
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
}

- (IBAction)onClickDoneBtn:(id)sender {
    [self HideDropdown];
}

@end
