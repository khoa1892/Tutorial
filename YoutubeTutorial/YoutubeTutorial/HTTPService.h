//
//  HTTPService.h
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray* __nullable dataArray, NSString* __nullable err);

@interface HTTPService : NSObject
+ (id) instance;
-(void) getTutorials: (nullable onComplete)completionHandler;
@end
