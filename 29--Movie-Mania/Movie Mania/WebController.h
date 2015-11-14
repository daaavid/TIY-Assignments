//
//  WebController.h
//  Movie Mania
//
//  Created by david on 11/14/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"

@interface WebController : NSObject <NSURLSessionDelegate>

@property (nonatomic) id <WebProtocol> delegate;

- (void)search:(NSString *)selectedMovieTitle;
- (void)findImage:(NSURL *)imageURL;

@end
