//
//  CheckEventListCell.m
//  CanMobile
//
//  Created by Optiplex790 on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckEventListCell.h"

@implementation CheckEventListCell
@synthesize m_labelTitle;
@synthesize m_labelLocation;
@synthesize m_labelDate;

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
    [m_labelLocation release];
    [m_labelDate release];
    [super dealloc];
}
@end
