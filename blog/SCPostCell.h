//
//  SCPostCell.h
//  blog
//
//  Created by Philip Dow on 2/6/14.
//  Copyright (c) 2014 Philip Dow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPostCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *previewView;
@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UILabel *authorLabel;

@end
