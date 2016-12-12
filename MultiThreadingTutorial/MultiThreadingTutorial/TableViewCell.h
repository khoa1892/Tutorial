//
//  TableViewCell.h
//  MultiThreadingTutorial
//
//  Created by Khoa on 10/25/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
-(void) configureCell:(UIImage *) image andTitle:(NSString *) label;
@end
