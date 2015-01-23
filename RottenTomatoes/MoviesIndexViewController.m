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

@interface MoviesIndexViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *moviesArray;
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
}

#pragma mark - API calls

- (void)getMovies
{
    NSLog(@"Retrieving movies from Rotten Tomatoes...");
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=re53qkp6bw9zp86m6zn7763x&limit=50&country=us";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError)
        {
            [self.networkError setHidden:NO];
        } else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.moviesArray = [json objectForKey:@"movies"];
            self.movies = [NSMutableArray arrayWithCapacity:self.moviesArray.count];
            
            for(NSDictionary *dictionary in self.moviesArray)
            {
                Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
                [self.movies addObject:movie];
            }
        }
        [self.tableView reloadData];
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
    Movie *movie = self.movies[indexPath.row];
    [cell configureWithMovie:movie];
    
    return cell;
}

#pragma mark - Table view methods -- Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesCell *cell = (MoviesCell *) [self.tableView cellForRowAtIndexPath:indexPath];

    MoviesDetailViewController *movieDetailViewController = [[MoviesDetailViewController alloc] init];
    movieDetailViewController.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
