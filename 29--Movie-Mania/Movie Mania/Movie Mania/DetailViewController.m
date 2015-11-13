//
//  DetailViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "DetailViewController.h"
//#import "PosterCollectionViewController.h"
#import "ActorTableViewController.h"
#import "ReviewsTableViewController.h"
#import "ZoomImageViewController.h"

@interface DetailViewController () <NSURLSessionDelegate>
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
    self.foreground.delegate = self;
    
    NSLog(@"children : %@", self.childViewControllers);
    
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
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@&tomatoes=true&y=&plot=short&r=json", formattedSearchTerm];
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
    
    NSString *allActors = (NSString *)searchResults[@"Actors"];
    
    NSLog(@"%@", allActors);
    
    NSArray *actorArr = (NSArray *)[allActors componentsSeparatedByString:@","];
    ActorTableViewController *actorVC = (ActorTableViewController *)self.childViewControllers[0];
    actorVC.actors = actorArr;
    [actorVC.tableView reloadData];

    NSString *imdbRating = (NSString *)searchResults[@"imdbRating"];
    NSString *metascore = (NSString *)searchResults[@"Metascore"];
    NSString *tomatoRating = (NSString *)searchResults[@"tomatoRating"];
    
    NSArray *scoreArr = [[NSArray alloc] initWithObjects:imdbRating, metascore, tomatoRating, nil];
    ReviewsTableViewController *reviewVC = (ReviewsTableViewController *)self.childViewControllers[1];
    reviewVC.reviews = scoreArr;
    [reviewVC.tableView reloadData];
    
    NSLog(@"%@, %@, %@", imdbRating, metascore, tomatoRating);
    
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
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage)];
        tapGesture.numberOfTapsRequired = 2;
        //    tapGestureRecognizer.delegate = self;
        [self.posterImage addGestureRecognizer:tapGesture];
        self.posterImage.userInteractionEnabled = YES; // default is no for UIImageView
    }
}

- (void)tappedImage
{
    NSLog(@"image tapped");
    ZoomImageViewController *zoomVC = (ZoomImageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ZoomImageViewController"];
//    zoomVC.img.image = self.posterImage.image;
    
    [zoomVC.img setImage:[UIImage imageNamed:@"avengers.jpg"]];
    
    [self presentViewController:zoomVC animated:YES completion:nil];
    
//    [self.navigationController pushViewController:zoomVC animated:YES];
}

//- (IBAction)showtimesNearMeButtonTapped:(UIButton *)sender
//{
//    NSString *urlString = @"https://www.google.com/movies?near=32303&rl=1&stok=ABAPP2sMrd9_PRWpVzEpf4FKA9AhYjNryA%3A1447369580919";
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//}

@end
