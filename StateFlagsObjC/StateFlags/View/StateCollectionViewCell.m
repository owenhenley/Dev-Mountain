//
//  StateCollectionViewCell.m
//  StateFlagsObjC
//
//  Created by Owen Henley on 7/30/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

#import "StateCollectionViewCell.h"

@interface StateCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateNameLabel;

@end

@implementation StateCollectionViewCell

// this is the hcorrect convention to follow

//traditional update views
-(void) updateViews:(OHState *)state
{
    if (state) {
        self.flagImageView.image = [UIImage imageNamed:state.abbreviation];
        self.stateNameLabel.text = state.name;
    }
}

//similar to didset
-(void)setState:(OHState *)state
{
    _state = state;
    [self updateViews:state];
}

@end
