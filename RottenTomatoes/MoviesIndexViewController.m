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
@property (nonatomic, strong) NSArray *movies;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
    
    //refresh
//    UIRefreshControl *refreshC = [[UIRefreshControl alloc] init];
//    [refreshC addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshC];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MoviesCell" bundle:nil] forCellReuseIdentifier:@"MoviesCell"];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = [Movie moviesWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        [self.tableView reloadData];
    }];
    
    //TODO: load indicator
}

//- (void)grabContent:(UIRefreshControl *)refreshControl
//{
//    
//}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
    cell.movie = self.movies[indexPath.row];
    return cell;
}

#pragma mark - Table view methods -- delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesDetailViewController *movieDetailViewController = [[MoviesDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:nil];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
