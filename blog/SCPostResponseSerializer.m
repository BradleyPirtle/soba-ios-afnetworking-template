//
//  SCPostResponseSerializer.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCPostResponseSerializer.h"
#import "SCPost.h"

@implementation SCPostResponseSerializer

- (id) responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
  NSDictionary *dictionary = [super responseObjectForResponse:response data:data error:error];
  if (!dictionary) {
    return nil;
  }
  
  SCPost *post = [SCPost postWithDictionary:dictionary];
  return post;
}


@end
