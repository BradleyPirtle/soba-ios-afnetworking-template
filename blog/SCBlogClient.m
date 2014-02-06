//
//  SCBlogClient.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCBlogClient.h"

static NSString * const SCBlogClientBaseURL = @"http://ec2-54-227-153-225.compute-1.amazonaws.com:3000/api/";
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

#pragma mark -

- (void) fetchPosts:(BOOL)refresh
  success:(void (^)(NSURLSessionDataTask *, id))success
  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
  if (!refresh) {
    success(nil, self.posts);
  } else {
    [self GET:@"posts" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
      self.posts = responseObject;
      success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      failure(task, error);
    }];
  }
}

- (void) createPost:(NSDictionary*)post
  success:(void (^)(NSURLSessionDataTask *task, NSDictionary* post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
  [self POST:@"posts" parameters:post success:^(NSURLSessionDataTask *task, NSDictionary *result) {
    NSMutableDictionary *merged = [post mutableCopy];
    [merged setValuesForKeysWithDictionary:result];
    [[self mutableArrayValueForKey:@"posts"] addObject:merged];
    success(task, [merged copy]);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    failure(task, error);
  }];
}

- (void) deletePost:(NSDictionary*)post
  success:(void (^)(NSURLSessionDataTask *task, NSDictionary *post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
  
  NSString *path = [self pathForPost:post];
  [self DELETE:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    [[self mutableArrayValueForKey:@"posts"] removeObject:post];
    success(task, responseObject);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    failure(task, error);
  }];
}

- (NSString*) pathForPost:(NSDictionary*)post
{
  return [@"posts" stringByAppendingPathComponent:[post valueForKey:@"_id"]];
}

@end
