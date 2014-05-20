//
//  TwitterTableCell.m
//  StudySocialApp-iOS
//
//  Created by Mark Cyril Anthony Heruela on 5/20/14.
//  Copyright (c) 2014 Huchcode. All rights reserved.
//

#import "TwitterTableCell.h"

@implementation TwitterTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
