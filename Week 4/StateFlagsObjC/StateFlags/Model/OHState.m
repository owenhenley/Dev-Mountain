//
//  OHState.m
//  StateFlags
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "OHState.h"

@implementation OHState

- (instancetype)initWithName:(NSString *)name abbreviation:(NSString *)abbreviation
{
    // new instance, call on super because we are subclassing
    self = [super init];
    // if let. memberwise init
    if (self) {
        _name = name;
        _abbreviation = abbreviation;
    }
    return self;
}

@end
