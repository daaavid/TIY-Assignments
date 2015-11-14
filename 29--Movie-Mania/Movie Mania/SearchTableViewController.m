//
//  SearchTableViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "SearchTableViewController.h"
#import "DetailViewController.h"

@interface SearchTableViewController () <UISearchBarDelegate, /*UISearchResultsUpdating,*/ NSURLSessionDelegate>
{
    NSMutableArray *searchResults;
    
    NSMutableData *receivedData;
    
    NSURLSessionDataTask *task;
    
    UIColor *bgColor;
    
    NSTimer *searchTimer;
    
    int searchTime;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bgColor = [UIColor colorWithHue:0.918 saturation:0.848 brightness:0.555 alpha:1];
    self.view.backgroundColor = bgColor;

    self.searchBar.delegate = self; //we are now intercepting data and functions that the search bar is sending to the system
    
    searchResults = [[NSMutableArray alloc] init];
    
    //trying to cut down on network activity
    searchTime = 0;
    searchTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(incrementSearchTime) userInfo: nil repeats: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count]; //we want as many rows as there are search results
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = searchResults[indexPath.row];
    
    cell.textLabel.text = (NSString *)dictionary[@"Title"];
    cell.detailTextLabel.text = (NSString *)dictionary[@"Year"];
    cell.backgroundColor = bgColor;

    return cell;
}

#pragma mark - search

- (void)incrementSearchTime
{
    searchTime += 1;

    if(searchTime > 50)
    {
        searchTime = 0;
    }
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSArray *visibleCells = self.tableView.visibleCells;
    
    if(visibleCells.count > 0) //making sure we have cells on the screen before we try to access a search term.
    {
        [self makeDetailVC:0]; //because if we don't, this <<< function will cause a crash.
    }
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search]; //search any time the user changes the text in the search bar.
//    [self.tableView reloadData]; //reload the view to display the search.
}

- (void)search
{
    if(searchTime % 2 == 0)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; //show the network activity thing in the status bar
        
        NSString *searchTerm = self.searchBar.text;
        NSString *formattedSearchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json", formattedSearchTerm];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        task = [session dataTaskWithURL:url];
        [task resume];
    }
}

- (void)cancel
{
    [task cancel];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData) //if haven't received data
    {
        receivedData = [[NSMutableData alloc] init];
        //initializing thing to store data
    }
    [receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //received all data or received error
    if (!error && receivedData != nil) //if there was no error and data has been received
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        NSArray *search = results[@"Search"];
        
        [searchResults removeAllObjects];
        [searchResults addObjectsFromArray:search];
        
        [self cancel];
        
        [searchTimer invalidate];
        
        [self.tableView reloadData];
        
        receivedData = nil;

    }
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeDetailVC:indexPath];
}

- (void)makeDetailVC:(NSIndexPath *)indexPath
{
    //instantiate view controller with identifier set in storyboard
    //make a dictionary in that view controller
    //set the dictionary equal to the dictionary that is in the index path of the cell we just selected
    
    DetailViewController *detailVC = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    NSDictionary *selectedMovieDictionary = searchResults[indexPath.row];
    
    NSString *selectedMovieTitle = selectedMovieDictionary[@"Title"];
    
    detailVC.selectedMovieTitle = selectedMovieTitle;
    
    [detailVC search];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
