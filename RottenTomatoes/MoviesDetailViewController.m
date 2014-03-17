//
//  MoviesDetailViewController.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "MoviesDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fullImage;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

@end

@implementation MoviesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
