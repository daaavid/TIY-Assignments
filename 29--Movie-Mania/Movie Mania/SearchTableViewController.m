//
//  SearchTableViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () <UISearchBarDelegate, /*UISearchResultsUpdating,*/ NSURLSessionDelegate>
{
    NSMutableArray *searchResults;
    NSMutableData *receivedData;
    NSURLSessionDataTask *task;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (nonatomic) UISearchBar *searchBar;
//@property (nonatomic) UISearchController *searchController;

@end

@implementation SearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.dimsBackgroundDuringPresentation = NO;
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchBar.delegate = self;
    
    searchResults = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//    NSDictionary *result = searchResults[indexPath.row];
    
    
    return cell;
}

#pragma mark - search

//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
//{
//    
//}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self search];
    [self.tableView reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
    
    [self search];
    [self.tableView reloadData];
}

- (void)search
{
    NSString *searchTerm = self.searchBar.text;
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json", searchTerm];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    task = [session dataTaskWithURL:url];
    [task resume];
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
    [receivedData appendData: data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //received all data or received error
    if (!error) //if there was no error
    {
        NSLog(@"Download success");
        NSArray *results = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
//        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
//        NSArray
//        
//        for(NSDictionary *result in results)
//        {
//            [searchResults addObject:result];
//            NSLog([NSString stringWithFormat:@"%@", result]);
//        }
        
        [self cancel];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end