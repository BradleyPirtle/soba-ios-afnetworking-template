//
//  SCPostRequestSerializer.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCPostRequestSerializer.h"
#import "SCPost.h"

@implementation SCPostRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error
{
  NSDictionary *dictionary = [parameters dictionaryRepresentation];
  return [super requestBySerializingRequest:request withParameters:dictionary error:error];
}

@end
