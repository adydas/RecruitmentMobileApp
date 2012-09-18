//
//  EventListCell.m
//  CanMobile
//
//  Created by Optiplex790 on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventListCell.h"

@implementation EventListCell
@synthesize m_labelName;
@synthesize m_btnCheckIn;

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
    [m_labelName release];
    [m_btnCheckIn release];
    [super dealloc];
}
@end
