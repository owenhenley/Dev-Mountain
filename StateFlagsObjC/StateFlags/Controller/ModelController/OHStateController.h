//
//  OHStateController.h
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHStateController : NSObject

//declare shared instance
+ (OHStateController *)shared;

//source of truth
@property (nonatomic, strong) NSArray *states;

- (NSArray *)addStates;

@end

NS_ASSUME_NONNULL_END
