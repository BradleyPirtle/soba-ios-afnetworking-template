//
//  SCPost.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCPost.h"

@implementation SCPost

+ (instancetype) postWithDictionary:(NSDictionary*)dictionary
{
  SCPost *post = [[[self class] alloc] init];
  
  [post setValue:[dictionary valueForKey:@"title"] forKey:@"title"];
  [post setValue:[dictionary valueForKey:@"author"] forKey:@"author"];
  [post setValue:[dictionary valueForKey:@"body"] forKey:@"body"];
  
  // must convert _id to an identifier
  [post setValue:[dictionary valueForKey:@"_id"] forKey:@"identifier"];
  
  return post;
}

- (NSDictionary*) dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  [dictionary setValue:[self valueForKey:@"title"] forKey:@"title"];
  [dictionary setValue:[self valueForKey:@"author"] forKey:@"author"];
  [dictionary setValue:[self valueForKey:@"body"] forKey:@"body"];
  
  // must vonvert identifier back to _id
  [dictionary setValue:[self valueForKey:@"identifier"] forKey:@"_id"];
  
  return dictionary;
}

#pragma mark -

- (id) copyWithZone:(NSZone *)zone
{
  return [SCPost postWithDictionary:[self dictionaryRepresentation]];
}

- (SCPost*) mergeUpdate:(SCPost*)post
{
  SCPost *merged = [self copy];
  NSArray *keys = @[@"identifier", @"title", @"author", @"body"];
  
  [keys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
    if ([post valueForKey:key]) {
      [merged setValue:[post valueForKey:key] forKey:key];
    }
  }];
  
  return merged;
}

@end
