//
//  StateCollectionViewCell.h
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHState.h"

NS_ASSUME_NONNULL_BEGIN

@interface StateCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, nonnull) OHState *state;

@end

NS_ASSUME_NONNULL_END
