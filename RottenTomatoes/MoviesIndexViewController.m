//
//  MoviesIndexViewController.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/12/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "MoviesCell.h"
#import "Movie.h"
#import "MoviesIndexViewController.h"
#import "MoviesDetailViewController.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesIndexViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *networkError;
@property BOOL checkAPIReachable;

@end

@implementation MoviesIndexViewController

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
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MoviesCell" bundle:nil];
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"MovieTableCell"];
    
    self.navigationItem.title = @"Top Box Office Movies";
    
    //Pulldown refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self.networkError setHidden:YES];
    
    NSLog(@"Test Reachability");
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];

    Reachability *reach = [Reachability reachabilityWithHostname:@"api.rottentomatoes.com"];
    
    reach.reachableBlock = ^(Reachability *reach)
    {
        self.checkAPIReachable = YES;
        [self.networkError setHidden:YES];
        NSLog(@"API is up!");
    };
    
    reach.unreachableBlock = ^(Reachability *reach)
    {
        self.checkAPIReachable = NO;
        [self.networkError setHidden:NO];
        NSLog(@"API is down!");
    };
    
    [reach startNotifier];

    self.navigationItem.title = @"Top Box Office Movies";

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self showSpinner];
}

#pragma mark - API calls

- (void)getMovies
{
    NSLog(@"Retrieving movies from Rotten Tomatoes...");
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=re53qkp6bw9zp86m6zn7763x&limit=50&country=us";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"API call complete");
            self.movies = [Movie moviesWithArray:json[@"movies"]];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Animation

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
    [self getMovies];
}

- (void)showSpinner
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self delayForSeconds];
        [self getMovies];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)delayForSeconds
{
    sleep(2);
}

#pragma mark - Table view methods -- Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell"];
    cell.movie = self.movies[indexPath.row];
    
    return cell;
}

#pragma mark - Table view methods -- Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell %ld",(long)indexPath.row);
    
    MoviesCell *cell = (MoviesCell *) [self.tableView cellForRowAtIndexPath:indexPath];

    NSLog(@"Choosing... %@",cell.description);
    
    MoviesDetailViewController *mDVC = [[MoviesDetailViewController alloc] init];
    mDVC.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:mDVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
