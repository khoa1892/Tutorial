//
//  VideoCell.m
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "VideoCell.h"
#import "Video.h"

@interface VideoCell ()
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

-(void) cellConfigure:(Video *)video {
    self.thumbImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.thumbnailUrl]]];
    self.titleLabel.text = video.videoTitle;
    self.descLabel.text = video.videoDescription;
}

@end
