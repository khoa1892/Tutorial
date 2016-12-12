//
//  Ship.h
//  ManualMemory
//
//  Created by Khoa on 12/12/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Ship : NSObject {
    Person *_captain;
}
-(Person *) captain;
-(void) setCaptain: (Person *)captain;
@end
