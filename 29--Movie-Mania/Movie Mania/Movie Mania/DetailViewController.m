//
//  DetailViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <NSURLSessionDelegate>
{
    NSDictionary *searchResults;
    NSMutableData *receivedData;
    NSURLSessionDataTask *task;

}

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testLabel.text = self.selectedMovieDictionary[@"Title"];
    // Do any additional setup after loading the view.
    
    [self search];
    searchResults = [[NSDictionary alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)search
{
    NSString *searchTerm = self.selectedMovieDictionary[@"Title"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@&y=&plot=short&r=json", searchTerm];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    task = [session dataTaskWithURL:url];
    [task resume];
}

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
        searchResults = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        self.testLabel.text =  (NSString *)searchResults[@"Director"];
        
       
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
