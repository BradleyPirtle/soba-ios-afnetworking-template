//
//  SCMasterViewController.m
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import "SCMasterViewController.h"
#import "SCDetailViewController.h"
#import "SCPostCell.h"
#import "SCBlogClient.h"

@interface SCMasterViewController ()

@end

@implementation SCMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[[SCBlogClient sharedInstance] posts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SCPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];

  NSDictionary *post = [[SCBlogClient sharedInstance] posts][indexPath.row];
  
  cell.titleLabel.text = [post valueForKey:@"title"];
  cell.authorLabel.text = [post valueForKey:@"author"];
  cell.previewView.image = [UIImage imageNamed:@"food.jpg"];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 78.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      [[SCBlogClient sharedInstance] deletePost:[[SCBlogClient sharedInstance] posts][indexPath.row]
        success:^(NSURLSessionDataTask *task, NSDictionary *post) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure to delete post: %@", error);
      }];
      
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [[SCBlogClient sharedInstance] posts][indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    } else if ([[segue identifier] isEqualToString:@"newPost"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark -

- (void) newPostViewDidSave:(SCNewPostViewController*)aController
{
  NSDictionary *newPost = @{
    @"title": aController.title,
    @"author": aController.author,
    @"body": aController.body
  };
  
  NSLog(@"did save %@", newPost);
  
  [[SCBlogClient sharedInstance] createPost:newPost success:^(NSURLSessionDataTask *task, NSDictionary *post) {
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[[[SCBlogClient sharedInstance] posts] count]-1 inSection:0]]
        withRowAnimation:UITableViewRowAnimationAutomatic];
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"Failure to create post: %@", error);
    // show the user
  }];
  
}

@end
