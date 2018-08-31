//
//  OHState.h
//  StateFlags
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHState : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abbreviation;

// memberwise initialiser/function signature
- (instancetype)initWithName: (NSString *)name abbreviation:(NSString *)abbreviation;

@end

NS_ASSUME_NONNULL_END
