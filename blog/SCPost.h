//
//  SCPost.h
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPost : NSObject <NSCopying>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *identifier;

+ (instancetype) postWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*) dictionaryRepresentation;

- (SCPost*) mergeUpdate:(SCPost*)post;

@end
