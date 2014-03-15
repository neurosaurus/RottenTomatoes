//
//  MovieCell.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/13/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "MovieInfoCell.h"

@implementation MovieInfoCell

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
