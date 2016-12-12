//
//  Ship.m
//  ManualMemory
//
//  Created by Khoa on 12/12/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "Ship.h"

@implementation Ship

-(void) setCaptain: (Person *)captain {
    [_captain autorelease];
    _captain = [captain retain];
}

-(Person *) captain {
    return _captain;
}

-(void)dealloc {
    NSLog(@"dealloc %@", _captain);
    [super dealloc];
}

@end
