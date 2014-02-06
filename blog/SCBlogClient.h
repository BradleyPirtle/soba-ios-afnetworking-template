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

+ (instancetype) sharedInstance;

@end
