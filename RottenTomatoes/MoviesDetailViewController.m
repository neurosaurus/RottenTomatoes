//
//  MoviesDetailViewController.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "MoviesDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"

@interface MoviesDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fullImage;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MoviesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.movie.title;
    self.titleLabel.text = self.movie.title;
    self.summaryLabel.text = self.movie.synopsis;
    
    self.summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.summaryLabel.numberOfLines = 0;
    
    NSURL *imageURL = [NSURL URLWithString:self.movie.poster];
    [self.fullImage setImageWithURL:imageURL];
    
    self.castLabel.text = self.movie.cast;
    self.castLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.castLabel.numberOfLines = 0;

}
- (void)viewDidAppear:(BOOL)animated
{

}

@end
