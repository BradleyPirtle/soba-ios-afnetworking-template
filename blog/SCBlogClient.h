//
//  SCBlogClient.h
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@class SCPost;

@interface SCBlogClient : AFHTTPSessionManager

@property (strong, atomic, readonly) NSArray *posts;

+ (instancetype) sharedInstance;

// must update client to support dictionaries or scpost

- (void) fetchPosts:(BOOL)refresh
  success:(void (^)(NSURLSessionDataTask *task, id posts))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createPost:(SCPost*)post
  success:(void (^)(NSURLSessionDataTask *task, SCPost *post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deletePost:(SCPost*)post
  success:(void (^)(NSURLSessionDataTask *task, SCPost *post))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
