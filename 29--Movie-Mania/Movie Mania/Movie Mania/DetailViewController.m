//
//  DetailViewController.m
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "DetailViewController.h"

#import "ActorTableViewController.h"
#import "ReviewsTableViewController.h"
#import "GenreTableViewController.h"

#import "PosterZoomViewController.h"

#import "WebController.h"
#import "Movie.h"

@interface DetailViewController () <UIPopoverPresentationControllerDelegate>/*<UIScrollViewDelegate>*/
{
    NSDictionary *searchResults;
    NSMutableData *receivedData;
    NSURLSessionDataTask *task;
    
    WebController *webController;
    Movie *movie;
}

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
//@property (weak, nonatomic) IBOutlet UIView *fetchingResultsView;
@property (weak, nonatomic) IBOutlet UIView *posterBlurView;

@property (weak, nonatomic) IBOutlet UIScrollView *background;
@property (weak, nonatomic) IBOutlet UIScrollView *foreground;

@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRuntimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieCountryLabel;

@property (weak, nonatomic) IBOutlet UITextView *moviePlotTextView;


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.background.delegate = self;
    self.posterBlurView.hidden = YES;
    self.movieTitleLabel.text = @"";
    self.moviePlotTextView.text = @"";
    self.movieRatingLabel.text = @"";
    self.movieRuntimeLabel.text = @"";
    self.movieReleaseLabel.text = @"";
    self.movieCountryLabel.text = @"";
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark - search called in saerch view controller

-(void)search
{
    webController = [[WebController alloc] init];
    webController.delegate = self;
    [webController search: self.selectedMovieTitle];
}

#pragma mark - function called when web controller retrieves movie dictionary

- (void)searchWasCompleted:(NSDictionary *)results;
{
    searchResults = results;
    
    [self populateView];
    
    NSLog(@"searchWasCompleted <<<<<<<<<<<");
}

#pragma mark - function called when web controller finds poster image for movie

- (void)imageWasFound:(UIImage *)image;
{
    if (image) //if we have an image. prevent crashes
    {
        self.posterImage.image = image;
        [self animatePosterImg];
        
        [self setupPosterTap];
    }
}

#pragma mark - view population

- (void)populateView
{
    movie = [[Movie alloc] initWithDictionary:searchResults];
    
    self.movieTitleLabel.text = movie.title;
    self.moviePlotTextView.text = movie.plot;
    self.movieRatingLabel.text = movie.rating;
    self.movieReleaseLabel.text = movie.year;
    self.movieRuntimeLabel.text = movie.runtime;
    self.movieCountryLabel.text = movie.country;
    
    if (movie.posterURL) //if we have a url for the image
    {
        NSURL *url = [NSURL URLWithString:movie.posterURL];
        [webController findImage:url];
    }
    
    [self populateChildViews];
}

- (void)populateChildViews
{
    NSLog(@"%@", self.childViewControllers);
    
    //review embedded tableview
    ReviewsTableViewController *reviewVC = (ReviewsTableViewController *)self.childViewControllers[0];
    reviewVC.reviews = movie.ratings;
    [reviewVC.tableView reloadData];
    
//  genre embedded tableview
    GenreTableViewController *genreVC = (GenreTableViewController *)self.childViewControllers[1];
    genreVC.genres = movie.genre;
    [genreVC.tableView reloadData];
    
    //actor embedded tableview
    ActorTableViewController *actorVC = (ActorTableViewController *)self.childViewControllers[2];
    actorVC.actors = movie.actors;
    [actorVC.tableView reloadData];
}


- (void)setupPosterTap
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage)];
    tapGesture.numberOfTapsRequired = 1;
    //    tapGestureRecognizer.delegate = self;
    [self.posterImage addGestureRecognizer:tapGesture];
    self.posterImage.userInteractionEnabled = YES; // default is no for UIImageView
}

- (void)tappedImage
{
    NSLog(@"image tapped");
    
    [self performSegueWithIdentifier:@"zoomPopoverSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"zoomPopoverSegue"])
    {
        PosterZoomViewController *posterVC = segue.destinationViewController;
        UIPopoverPresentationController *popover = posterVC.popoverPresentationController;
        popover.delegate = self;
        
        posterVC.imageURL = movie.posterURL;
        
        UIColor *bgColor = [UIColor colorWithHue:0.902 saturation:0.761 brightness:0.527 alpha:1];
        posterVC.view.backgroundColor = bgColor;
        
        posterVC.modalPresentationStyle = UIModalPresentationPopover;
        posterVC.preferredContentSize = CGSizeMake(360, 528);
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (IBAction)showtimesNearMeButtonTapped:(UIButton *)sender
{
    NSString *urlString = @"https://www.google.com/movies?near=32303&rl=1&stok=ABAPP2sMrd9_PRWpVzEpf4FKA9AhYjNryA%3A1447369580919";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
 
 
 
/*
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    double fgHeight = self.foreground.contentSize.height - CGRectGetHeight(self.foreground.bounds);
    double percentageScroll = self.foreground.contentOffset.y / fgHeight;
    double bgHeight = self.background.contentSize.height - CGRectGetHeight(self.background.bounds);
    self.background.contentOffset = CGPointMake(0, bgHeight * percentageScroll);
}
*/

@end
