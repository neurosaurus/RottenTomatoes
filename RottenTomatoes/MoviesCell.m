//
//  MoviesCell.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Movie.h"
#import "MoviesCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesCell ()


@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@end

@implementation MoviesCell

- (void)awakeFromNib
{
    //Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public methods

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    
    self.movieTitle.text = _movie.title;
    self.synopsis.text = _movie.synopsis;
    
    [self.posterView setImageWithURL:[NSURL URLWithString:_movie.posterURL]];
}

@end
