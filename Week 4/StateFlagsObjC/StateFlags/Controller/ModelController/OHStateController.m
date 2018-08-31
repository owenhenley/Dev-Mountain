//
//  OHStateController.m
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "OHStateController.h"
#import "OHStateHelper.h"
#import "OHState.h"

@implementation OHStateController

// stared instance
+ (OHStateController *)shared {
    static OHStateController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [OHStateController new];
    });
    return shared;
}

//initialiser
//every time class in initialised, thsi will run
- (instancetype) init
{
    self = [super init];
    if (self) {
        _states = [self addStates];
    }
    return self;
}

// - is an instance method(return type) creating an addrress in memory
- (NSArray *)addStates
{
    //create variable array, allocating array in memory, initialing array
    NSMutableArray *statesPlaceholder = [[NSMutableArray alloc] init];
    //find state name index, loop through states[function call]
    for (NSString* stateFullName in [OHStateHelper states]) {
        
        NSInteger index = [[OHStateHelper states] indexOfObject: stateFullName];
        
        NSString* abbreviation = [OHStateHelper abbreviation][index];
        
        OHState* state = [[OHState alloc] initWithName:stateFullName abbreviation:abbreviation];
        
        // append by calling a fucntion
        [statesPlaceholder addObject:state];
    }
    return statesPlaceholder;
}


@end
