//
//  JobListCell.h
//  CanMobile
//
//  Created by Optiplex790 on 9/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobListCell : UITableViewCell {
    
}

@property (retain, nonatomic) IBOutlet UILabel *m_labelTitle;
@property (retain, nonatomic) IBOutlet UILabel *m_labelDescription;
@property (retain, nonatomic) IBOutlet UIButton *m_btnEdit;
@property (retain, nonatomic) IBOutlet UIButton *m_btnFavorite;
@property (retain, nonatomic) IBOutlet UIButton *m_btnDetail;


@end
