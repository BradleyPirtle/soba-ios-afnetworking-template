//
//  SCNewPostViewController.h
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewPostViewController;

@protocol SCNewPostViewController <NSObject>

- (void) newPostViewDidSave:(SCNewPostViewController*)aController;

@end

@interface SCNewPostViewController : UITableViewController

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *body;

@property (weak, nonatomic) id<SCNewPostViewController> delegate;

- (IBAction)save:(id)sender;

@end
