//
//  main.m
//  ManualMemory
//
//  Created by Khoa on 12/12/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *_name;
}
-(void) setName: (NSString *) name;
-(NSString *) getName;
@end
@implementation Person
-(void) setName: (NSString *) name {
    _name = name;
}
-(NSString *) getName {
    return _name;
}

@end


int main(int argc, const char * argv[]) {
    Person *person = [[Person alloc] init];
    [person setName:@"Khoa"];
    NSLog(@"%@", [person getName]);
    [person release];
    return 0;
}
