//
//  Bird.m
//  MultiThreadingTutorial
//
//  Created by Khoa on 10/25/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "Bird.h"

@implementation Bird
-(id) initWithDic:(NSMutableDictionary *)dict {
    if ([self isEqual:[super init]]) {
        self.birdName = dict[@"tenChim"];
        self.idName = dict[@"idChim"];
        self.birdImage = dict[@"hinhChim"];
    }
    return self;
}

@end
