//
//  TableViewCell.m
//  MultiThreadingTutorial
//
//  Created by Khoa on 10/25/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) configureCell:(UIImage *) image andTitle:(NSString *) label {
    self.imageView.image = image;
    self.nameLabel.text = label;
}

    
@end
