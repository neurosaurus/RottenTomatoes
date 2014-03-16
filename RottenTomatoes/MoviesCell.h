//
//  MoviesCell.h
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MoviesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbNail;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;

@end
