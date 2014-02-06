//
//  SCPostsResponseSerializer.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCPostsResponseSerializer.h"
#import "SCPost.h"

@implementation SCPostsResponseSerializer

- (id) responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
  NSArray *dictionaries = [super responseObjectForResponse:response data:data error:error];
  if (!dictionaries) {
    return nil;
  }
  
  NSMutableArray *posts = [NSMutableArray array];
  [dictionaries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    SCPost *post = [SCPost postWithDictionary:obj];
    if (post) [posts addObject:post];
  }];
  
  return posts;
}

@end
