//
//  Video.h
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoiFrame;
@property (nonatomic, strong) NSString *thumbnailUrl;
-(id) initWithDict: (NSDictionary *) dict;
@end
