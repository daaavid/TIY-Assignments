//
//  DetailViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <NSURLSessionDelegate, UIScrollViewDelegate>
{
    NSDictionary *searchResults;
    NSMutableData *receivedData;
    NSURLSessionDataTask *task;
}

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UIView *fetchingResultsView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *posterBlurView;

@property (weak, nonatomic) IBOutlet UIScrollView *background;
@property (weak, nonatomic) IBOutlet UIScrollView *foreground;


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.background.delegate = self;
    
    searchResults = [[NSDictionary alloc]init];
    self.posterBlurView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)animatePosterImg
{
    [UIView animateWithDuration:0.5 animations: ^
    {
        self.posterBlurView.hidden = NO;
        self.posterBlurView.alpha = 0;
        self.posterBlurView.alpha = 1;
    }];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    double fgHeight = self.foreground.contentSize.height - CGRectGetHeight(self.foreground.bounds);
    double percentageScroll = self.foreground.contentOffset.y / fgHeight;
    double bgHeight = self.background.contentSize.height - CGRectGetHeight(self.background.bounds);
    self.background.contentOffset = CGPointMake(0, bgHeight * percentageScroll);
    
}

#pragma mark - detailed search

-(void)search
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *searchTerm = self.selectedMovieTitle;
    NSString *formattedSearchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@&y=&plot=short&r=json", formattedSearchTerm];
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
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        self.fetchingResultsView.hidden = YES;
        NSLog(@"Download success");
        searchResults = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        [self populateView];
    }
}

- (void)populateView
{
    NSString *urlString = (NSString *)searchResults[@"Poster"];
    
    if (urlString)
    {
        NSURL *url = [NSURL URLWithString:urlString];
        [self loadImage:url];
    }
}

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)image
{
    if (image)
    {
        self.posterImage.image = image;
//        [self.posterImage setImage:image];
        [self animatePosterImg];
    }
}
- (IBAction)showtimesNearMeButtonTapped:(UIButton *)sender
{
    NSString *urlString = @"https://www.google.com/movies?near=32303&rl=1&stok=ABAPP2sMrd9_PRWpVzEpf4FKA9AhYjNryA%3A1447369580919";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
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
