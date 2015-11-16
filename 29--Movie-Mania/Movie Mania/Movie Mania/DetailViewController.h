//
//  DetailViewController.h
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebProtocol

- (void)searchWasCompleted:(NSDictionary *)results;
- (void)imageWasFound:(UIImage *) image;

@end

@interface DetailViewController : UIViewController <UIScrollViewDelegate, WebProtocol>

@property (nonatomic) NSString *selectedMovieTitle;
@property (nonatomic) NSString *selectedMovieYear;

@end
