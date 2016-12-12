//
//  Bird.h
//  MultiThreadingTutorial
//
//  Created by Khoa on 10/25/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Bird : NSObject
@property (nonatomic, strong) NSString *birdName;
@property (nonatomic, strong) NSNumber *idName;
@property (nonatomic, strong) NSString *birdImage;
@property (nonatomic, strong) NSMutableDictionary * dict;

-(id) initWithDic: (NSMutableDictionary *) dict;
@end
