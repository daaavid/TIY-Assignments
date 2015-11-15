//
//  SearchTableViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "SearchTableViewController.h"
#import "DetailViewController.h"
#import "HistoryTableViewController.h"

@interface SearchTableViewController () <UISearchBarDelegate, NSURLSessionDelegate, UIPopoverPresentationControllerDelegate>
{
    NSMutableArray *searchResults;
    
    NSMutableArray *searchHistory;
    
    NSMutableData *receivedData;
    
    NSURLSessionDataTask *task;
    
    NSTimer *searchTimer;
    
    BOOL searchTime;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *historyButton;

@end

@implementation SearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:0.918 saturation:0.848 brightness:0.555 alpha:1];

    self.searchBar.delegate = self; //we are now intercepting data and functions that the search bar is sending to the system
    self.historyButton.enabled = NO; //there aren't any history items yet
    
    UITextField *searchBarTextField = (UITextField *)[self.searchBar valueForKey:@"searchField"];
    searchBarTextField.textColor = [UIColor whiteColor];
    
    searchResults = [[NSMutableArray alloc] init];
    searchHistory = [[NSMutableArray alloc] init];
    
    //trying to cut down on network activity. search will only work when searchTime is YES, which happens every .5s
    searchTime = 0;
    searchTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(incrementSearchTime) userInfo: nil repeats: YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    cell.backgroundColor = [UIColor colorWithHue:0.918 saturation:0.848 brightness:0.555 alpha:1];;

    return cell;
}

#pragma mark - search

- (void)incrementSearchTime
{
    searchTime = !searchTime;
    //flipping the YES/NO value of saerchTime
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSArray *visibleCells = self.tableView.visibleCells;
    
    if(visibleCells.count > 0) //making sure we have cells on the screen before we try to access a search term.
    {
        [self makeDetailVC:0]; //because if we don't, this <<< function will cause a crash.
    }
    else
    {
        [self search];
    }
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search]; //search any time the user changes the text in the search bar.
//    [self.tableView reloadData]; //reload the view to display the search.
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
    [self.tableView reloadData];
}

- (void)search
{
    if(searchTime) //if searchTime is yes
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowHistoryPopover"])
    {
        HistoryTableViewController *historyVC = segue.destinationViewController;
        UIPopoverPresentationController *popover = historyVC.popoverPresentationController;
        popover.delegate = self;
        historyVC.delegate = self;
        
        historyVC.history = searchHistory;
        
        historyVC.modalPresentationStyle = UIModalPresentationPopover;
        float contentSize = searchHistory.count * 44;
        
        historyVC.preferredContentSize = CGSizeMake(200, contentSize);
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeDetailVC:indexPath];
}

- (void)makeDetailVC:(NSIndexPath *)indexPath
{
    self.historyButton.enabled = YES; //we know we have search results now

    //instantiate view controller with identifier set in storyboard
    //make a dictionary in that view controller
    //set the dictionary equal to the dictionary that is in the index path of the cell we just selected
    
    DetailViewController *detailVC = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    NSDictionary *selectedMovieDictionary = searchResults[indexPath.row];
    
    [searchHistory addObject: selectedMovieDictionary];
    
    NSString *selectedMovieTitle = selectedMovieDictionary[@"Title"];
    NSString *selectedMovieYear = selectedMovieDictionary[@"Year"];
    
    detailVC.selectedMovieTitle = selectedMovieTitle;
    detailVC.selectedMovieYear = selectedMovieYear;
    
    [detailVC search];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)historySearchResultWasChosen:(NSDictionary *)result;
{
    DetailViewController *detailVC = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    NSDictionary *selectedSearchHistoryResult = result;
    NSString *selectedMovieTitle = selectedSearchHistoryResult[@"Title"];
    NSString *selectedMovieYear = selectedSearchHistoryResult[@"Year"];
    
    NSLog(@"history search result was chosen");
    
    detailVC.selectedMovieTitle = selectedMovieTitle;
    detailVC.selectedMovieYear = selectedMovieYear;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
