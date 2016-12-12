//
//  main.m
//  ManualMemory
//
//  Created by Khoa on 12/12/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Ship.h"

int main(int argc, const char * argv[]) {
    Person *person = [[Person alloc] init];
    Ship *discoverOne = [[Ship alloc] init];
    person.name = @"Khoa";
    [discoverOne setCaptain:person];
    NSLog(@"%@", [discoverOne captain].name);
    [person release];
    NSLog(@"%@", [discoverOne captain]. name);
    [discoverOne release];
    return 0;
}

