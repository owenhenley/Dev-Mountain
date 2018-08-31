//
//  OHPostController.m
//  RedditObjC
//
//  Created by Owen Henley on 8/1/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "OHPostController.h"

@implementation OHPostController

// https://www.reddit.com/r/searchTerm.json

static NSString *baseURLAsString = @"https://www.reddit.com/r";

+ (OHPostController *)shared
{
        //shared instance
    static OHPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [OHPostController new];
    });
    return shared;
}

- (void)getSubredditsWithSearchTerm:(NSString *)searchTerm completion:(void (^)(BOOL))completion
{
    // create url
    NSURL *baseURL = [NSURL URLWithString:baseURLAsString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent: searchTerm];
    NSURL *dataTaskURL = [searchURL URLByAppendingPathExtension:@"json"];
//    NSString *imageURLAsString = JSONDictionary[@"thumbnail"]
    
//    if (jsonDictionary[@"thumbnail"] !=nil) {
//
//    }
    
    //request
    
    //datatask
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:dataTaskURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"there was an error retreiving teh json: %@", error);
            completion(false);
            return;
        }
        if (!data) {
            completion(false);
            return;
        }
        
        // work down the JSON tree starting with the top most point
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (topLevelDictionary == nil) {
            completion(false);
            return;
        }
        
        // go inside data
        NSDictionary *dataDictionary = [topLevelDictionary objectForKey: @"data"];
        
        // go into children
        NSArray *childernArray = [dataDictionary objectForKey:@"children"];
        
        //create a placeholder array for loop. Mini SOT take over
        NSMutableArray *posts = [NSMutableArray new];
        
        //go into children dictionaries
        for (NSDictionary *dictionary in childernArray) {
            NSDictionary *postDictionary = [dictionary objectForKey:@"data"];
            
            // init new model object, pass in dictionary and pass it put data
            OHPost * post = [[OHPost alloc] initWithJSONDictionary:postDictionary];
            
            // add post to array
            [posts addObject:post];
        }
        self.posts = posts;
        completion(true);
    }];
    [dataTask resume];
}

- (void)getImageForPost:(OHPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    
    // Step 1 - Create the URL
    NSURL *url = [NSURL URLWithString:post.imageURLAsString];
    
    // Step 3 - DataTask + RESUME
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (data == nil) {
            completion(nil);
            return;
        }
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        completion(image);
    }];
    [dataTask resume];
}



@end
