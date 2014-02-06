//
//  SCBlogClient.h
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface SCBlogClient : AFHTTPSessionManager

@property (strong, atomic, readonly) NSArray *posts;

+ (instancetype) sharedInstance;

- (void) fetchPosts:(BOOL)refresh
  success:(void (^)(NSURLSessionDataTask *task, id posts))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createPost:(NSDictionary*)post
  success:(void (^)(NSURLSessionDataTask *task, NSDictionary *post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deletePost:(NSDictionary*)post
  success:(void (^)(NSURLSessionDataTask *task, NSDictionary *post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
