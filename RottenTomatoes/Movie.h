//
//  Movie.h
//  RottenTomatoes
//
//  Created by Tripta Gupta on 3/15/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSURL *thumbNail;
@property (nonatomic) NSURL *poster;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
