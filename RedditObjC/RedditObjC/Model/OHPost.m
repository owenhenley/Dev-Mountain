//
//  OHPost.m
//  RedditObjC
//
//  Created by Owen Henley on 8/1/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "OHPost.h"

@implementation OHPost

//- (instancetype)initWithTitle:(NSString *)title ups:(NSNumber *)ups commentCount:(NSNumber *)commentCount
//{
//    self = [super init];
//    if (self) {
//        _title = [title copy];
//        _ups = ups;
//        _commentCount = commentCount;
//    }
//    return self;
//}

@end

@implementation OHPost (JSONConvertible)

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    //Json keys
    NSString *title = jsonDictionary[@"title"]; // Short Hand
    NSNumber *ups = [jsonDictionary objectForKey:@"ups"]; //Long Hand
    NSNumber *commentCount = jsonDictionary[@"num_comments"];
    
    //empty string placeholder
    NSString *imageURLAsString = jsonDictionary = @"";
    
    // If the thumbnail URL is equal to 'self', then set the post's imageURLAsString to the "image not found" URL
    if ([jsonDictionary[@"thumbnail"] isEqualToString:@"self"]) {
        imageURLAsString = @"https://www.abortionno.org/wp-content/uploads/2016/02/no-image-found.jpg";
        //if not, do this
    } else {
        imageURLAsString = jsonDictionary[@"thumbnail"];
    }
    
    self = [super init];
    if (self) {
        _title = [title copy];
        _ups = ups;
        _commentCount = commentCount;
        _imageURLAsString = [imageURLAsString copy];
        
    }
    return self;
}


@end
