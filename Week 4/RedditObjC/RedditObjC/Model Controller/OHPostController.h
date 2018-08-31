//
//  OHPostController.h
//  RedditObjC
//
//  Created by Owen Henley on 8/1/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OHPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface OHPostController : NSObject

// shared SOT., Empty array
@property (nonatomic, readwrite, copy) NSMutableArray<OHPost *> *posts;

// shared instance
+ (OHPostController *)shared;

//instance method
- (void) getSubredditsWithSearchTerm: (NSString *)searchTerm
                          completion: (void(^)(BOOL))completion;

-(void) getImageForPost: (OHPost *)post
             completion:(void(^) (UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
