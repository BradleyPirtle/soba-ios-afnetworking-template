//
//  SCBlogClient.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCBlogClient.h"

static NSString * const SCBlogClientBaseURL = @"http://news.google.com";
static NSString * const SCBlogClientLocalhostBaseURL = @"http://localhost:3000/api/";

@interface SCBlogClient ()

@property (strong, atomic, readwrite) NSArray *posts;

@end

#pragma mark -

@implementation SCBlogClient

+ (instancetype) sharedInstance
{
  //  Static local predicate must be initialized to 0
  static SCBlogClient *sharedInstance = nil;
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken, ^{
      sharedInstance = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:SCBlogClientLocalhostBaseURL]];
    
      // Do any other initialisation stuff here
      sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
      sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
  });
  return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
  self = [super initWithBaseURL:url];
  if (self) {
    _posts = [NSArray array];
  }
  return self;
}

@end
