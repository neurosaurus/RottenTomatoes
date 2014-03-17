//
//  Movie.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.thumbNail = dictionary[@"thumbnail"];
        self.poster = dictionary[@"posters"];
        self.cast = dictionary[@"cast"];
        self.synopsis = dictionary[@"synopsis"];
    }
    return self;
}

+ (NSArray *)moviesWithArray:(id)object
{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in object[@"movies"])
    {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return [movies copy];
}

@end
