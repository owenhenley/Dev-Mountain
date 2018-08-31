//
//  OHStatesCollectionViewController.m
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "OHStatesCollectionViewController.h"
#import "OHStateController.h"
#import "StateCollectionViewCell.h"
#import "OHState.h"
#import "OHStateController.h"

@interface OHStatesCollectionViewController ()

@end

@implementation OHStatesCollectionViewController

static NSString * const reuseIdentifier = @"stateCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[OHStateController shared] states]count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    OHState *state = [OHStateController shared].states[indexPath.row];
    
    cell.state = state;
    
    return cell;
}

@end
