//
//  Video.m
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "Video.h"

@implementation Video
-(id) initWithDict: (NSDictionary *) dict {
    if ([self isEqual:[super init]]) {
        self.videoDescription = dict[@"description"];
        self.videoTitle = dict[@"title"];
        self.thumbnailUrl = dict[@"thumbnail"];
        self.videoiFrame = dict[@"iframe"];
    }
    return self;
}
@end
