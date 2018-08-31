//
//  OHPost.h
//  RedditObjC
//
//  Created by Owen Henley on 8/1/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSNumber *ups;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, copy, readonly) NSString *imageURLAsString;

- (instancetype) initWithTitle:(NSString *)title
                           ups:(NSNumber *)ups
                  commentCount:(NSNumber *)commentCount;

@end

@interface OHPost (JSONConvertable)

- (instancetype) initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
