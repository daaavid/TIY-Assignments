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
    
    UIColor *bgColor;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bgColor = [UIColor colorWithHue:0.918 saturation:0.848 brightness:0.555 alpha:1];
    self.view.backgroundColor = bgColor;

    self.searchBar.delegate = self;
    
    searchResults = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = searchResults[indexPath.row];
    
    cell.textLabel.text = (NSString *)dictionary[@"Title"];
    cell.detailTextLabel.text = (NSString *)dictionary[@"Year"];
    cell.backgroundColor = bgColor;
    
    
    return cell;
}

#pragma mark - search

//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
//{
//    
//}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self search];
    [self.tableView reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search];
    [self.tableView reloadData];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self search];
    [self.tableView reloadData];
}

- (void)search
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *searchTerm = self.searchBar.text;
    NSString *formattedSearchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json", formattedSearchTerm];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    [task resume];
}

- (void)cancel
{
//    [task cancel];
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
    if (!error) //if there was no error
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        NSArray *search = results[@"Search"];
        
        [searchResults removeAllObjects];
        [searchResults addObjectsFromArray:search];
        
//        NSLog(@"%@", searchResults);
        
        [self cancel];
        receivedData = nil;
        
        [self.tableView reloadData];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    NSDictionary *selectedMovieDictionary = searchResults[indexPath.row];
    NSString *selectedMovieTitle = selectedMovieDictionary[@"Title"];
    
    detailVC.selectedMovieTitle = selectedMovieTitle;
    
    [detailVC search];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    //instantiate view controller with identifier set in storyboard
    //make a dictionary in that view controller
    //set the dictionary equal to the dictionary that is in the index path of the cell we just selected
}

@end
