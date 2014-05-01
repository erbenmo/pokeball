//
//  PokeballViewController.h
//  Pokeball
//
//  Created by Mo, Erben on 4/30/14.
//  Copyright (c) 2014 Mo, Erben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokeballViewController : UIViewController<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIGravityBehavior* gravity;
@property (nonatomic, strong) UICollisionBehavior* bounce;
@property (nonatomic, strong) UIDynamicItemBehavior* elasticity;

@property (nonatomic, strong) UIImageView* pokeball;

@property int bounceCounter;

@end
