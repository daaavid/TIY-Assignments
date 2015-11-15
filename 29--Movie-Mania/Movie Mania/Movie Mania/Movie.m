//
//  Movie.m
//  Movie Mania
//
//  Created by david on 11/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary: (NSDictionary *)searchResults;
{
    if (self = [super init])
    {
        _title = [(NSString *)searchResults[@"Title"] uppercaseString];
        _year = (NSString *)searchResults[@"Released"];
        
        NSString *genres = searchResults[@"Genre"];
        NSArray *genreArr = [genres componentsSeparatedByString:@","];
        _genre = genreArr;
        
        NSString *allActors = (NSString *)searchResults[@"Actors"];
        NSArray *actorArr = (NSArray *)[allActors componentsSeparatedByString:@","];
        _actors = actorArr;
        
        _plot = (NSString *)searchResults[@"Plot"];
        _posterURL = (NSString *)searchResults[@"Poster"];
        
        NSString *imdbRating = (NSString *)searchResults[@"imdbRating"];
        NSString *metascore = (NSString *)searchResults[@"Metascore"];
        NSString *tomatoRating = (NSString *)searchResults[@"tomatoRating"];
        
        _ratings = [[NSArray alloc] initWithObjects:imdbRating, metascore, tomatoRating, nil];
        
        _runtime = (NSString *)searchResults[@"Runtime"];
        _rating = (NSString *)searchResults[@"Rated"];
        _country = (NSString *)searchResults[@"Country"];
        
        _boxOffice = (NSString *)searchResults[@"BoxOffice"];
        _production = (NSString *)searchResults[@"Production"];
        _awards = (NSString *)searchResults[@"Awards"];
        _consensus = (NSString *)searchResults[@"tomatoConsensus"];
    }
    return self;
}

@end