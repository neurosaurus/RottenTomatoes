//
//  MoviesCell.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Movie.h"
#import "MoviesCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@end

@implementation MoviesCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

# pragma mark - Public Methods

- (void)setMovie:(Movie *)movie{
    _movie = movie;
    
    self.movieTitle.text = movie.title;
    self.synopsis.text = movie.synopsis;
    
    NSLog(@"%@", movie.thumbnail);
    
    [self.thumbnail setImageWithURL:[NSURL URLWithString:movie.thumbnail]];
}

@end