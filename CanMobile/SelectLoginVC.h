//
//  SelectLoginVC.h
//  CanMobile
//
//  Created by Optiplex790 on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLoginVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
}

@property (retain, nonatomic) IBOutlet UIView *m_viewPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *m_pickerView;

- (void) ShowDropdown;
- (void) HideDropdown;
- (void) datepickerAnimationEnded;

- (IBAction) onClickChooseStateBtn:(id)sender;
- (IBAction) onClickChooseSchoolBtn:(id)sender;
- (IBAction) onClickLoginBtn:(id)sender;
- (IBAction) onClickDoneBtn:(id)sender;

@end
