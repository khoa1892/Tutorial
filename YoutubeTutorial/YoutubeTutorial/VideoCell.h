//
//  VideoCell.h
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;

@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
-(void) cellConfigure:(Video*)video;
@end
