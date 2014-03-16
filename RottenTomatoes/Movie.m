//
//  Movie.m
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Movie.h"
#import "Cast.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.thumbNail = dictionary[@"posters"][@"thumbnail"];
        self.poster = dictionary[@"posters"][@"profile"];
        self.cast = dictionary[@"cast"];
        self.synopsis = dictionary[@"synopsis"];
    }
    return self;
}

@end
