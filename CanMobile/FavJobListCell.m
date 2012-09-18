//
//  JobListCell.m
//  CanMobile
//
//  Created by Optiplex790 on 9/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavJobListCell.h"

@implementation FavJobListCell
@synthesize m_labelTitle;
@synthesize m_labelDescription;
@synthesize m_btnEdit;
@synthesize m_btnFavorite;
@synthesize m_btnDetail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [m_labelTitle release];
    [m_labelDescription release];
    [m_btnEdit release];
    [m_btnFavorite release];
    [m_btnDetail release];
    [super dealloc];
}
@end
