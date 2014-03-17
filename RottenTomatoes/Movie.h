//
//  Movie.h
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSURL *thumbNail;
@property (nonatomic, strong) NSURL *posterUrl;
@property (nonatomic, strong) NSString *cast;

- (id)initWithDictionary:(NSDictionary*)dictionary;
+ (NSArray *)moviesWithArray:(id)object;

@end
