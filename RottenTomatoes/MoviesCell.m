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

- (void)configureWithMovie:(Movie *)movie
{
    _movie = movie;
    self.movieTitle.text = movie.title;
    self.synopsis.text = movie.synopsis;
    
    NSURL *imageURL = [NSURL URLWithString:movie.thumbnail];
    [self.thumbnail setImageWithURL:imageURL];
}

@end