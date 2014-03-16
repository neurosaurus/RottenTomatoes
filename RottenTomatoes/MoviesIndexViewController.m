//
//  MoviesIndexViewController.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/12/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "MoviesCell.h"
#import "MoviesIndexViewController.h"
#import "MoviesDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesIndexViewController ()

@property (nonatomic, weak) IBOutlet UITableView *moviesIndex;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MoviesIndexViewController

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
    
    self.moviesIndex.delegate = self;
    self.moviesIndex.dataSource = self;
    
    UINib *movieNib = [UINib nibWithNibName:@"MoviesCell" bundle:nil];
    [self.moviesIndex registerNib:movieNib forCellReuseIdentifier:@"MoviesCell"];
//    MoviesRequest *request = [[MoviesRequest alloc] init];
//    
//    [request getMovies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Hello World"];

    return cell;
    
}



//- (UITableViewCell *)cell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
//    
//    return cell;
//}

@end
