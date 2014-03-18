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
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesIndexViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *moviesArray;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MoviesCell" bundle:nil] forCellReuseIdentifier:@"MoviesCell"];
    
    self.navigationItem.title = @"Top Box Office Movies";
    
    //refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Release to Refresh"];
    [self.tableView addSubview:refreshControl];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=re53qkp6bw9zp86m6zn7763x&limit=50&country=us";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.moviesArray = [json objectForKey:@"movies"];
        self.movies = [NSMutableArray arrayWithCapacity:self.moviesArray.count];
        
        for(NSDictionary *dictionary in self.moviesArray)
        {
            Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
            [self.movies addObject:movie];
        }
        [self.tableView reloadData];
    }];
}

//implement refresh
- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    [self viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods -- datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell"];
    Movie *movie = self.movies[indexPath.row];
    [cell configureWithMovie:movie];
    
    return cell;
}

#pragma mark - Table view methods -- delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesCell *cell = (MoviesCell *) [self.tableView cellForRowAtIndexPath:indexPath];

    MoviesDetailViewController *movieDetailViewController = [[MoviesDetailViewController alloc] init];
    movieDetailViewController.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
