//
//  OHStateHelper.h
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHStateHelper : NSObject

//return arrys of all the states
//+ means its a class method
// returning an (NSarray)
+ (NSArray *)states;
+ (NSArray *)abbreviation;

@end

NS_ASSUME_NONNULL_END
