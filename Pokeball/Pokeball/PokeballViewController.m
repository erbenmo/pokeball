//
//  PokeballViewController.m
//  Pokeball
//
//  Created by Mo, Erben on 4/30/14.
//  Copyright (c) 2014 Mo, Erben. All rights reserved.
//

#import "PokeballViewController.h"

@interface PokeballViewController ()

@end

@implementation PokeballViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage* image = [UIImage imageNamed:@"Pokeball.png"];
    self.pokeball = [[UIImageView alloc] initWithImage:image];
    self.pokeball.frame = CGRectMake(100, 60, 40, 40);
    [self.view addSubview:self.pokeball];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // gravity
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.pokeball]];
    self.gravity.magnitude = 2.0;
    [self.animator addBehavior:self.gravity];
    
    
    // bounce on the floor..
    self.bounce = [[UICollisionBehavior alloc] initWithItems:@[self.pokeball]];
    self.bounce.translatesReferenceBoundsIntoBoundary = YES;
    self.bounce.collisionDelegate = self;
    [self.animator addBehavior:self.bounce];
    self.elasticity = [[UIDynamicItemBehavior alloc] initWithItems:@[self.pokeball]];
    self.elasticity.elasticity = 0.65f;
    [self.animator addBehavior:self.elasticity];
    
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    self.bounceCounter++;
    
    if(self.bounceCounter >= 7) {
        self.bounceCounter = 0;
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self shakeBall];
        });
    }
}

- (void)shakeBall {
    float shake_t = 0.3;
    float wait_t = 0.6;
    float x_dist = 8;
    float degree = M_PI/4;
    
    [UIView animateWithDuration:shake_t delay:wait_t options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.pokeball.transform = CGAffineTransformMakeRotation(-degree);
        self.pokeball.center = CGPointMake(self.pokeball.center.x - x_dist, self.pokeball.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:shake_t delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, +degree);
            self.pokeball.center = CGPointMake(self.pokeball.center.x + x_dist, self.pokeball.center.y);

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:shake_t delay:wait_t options:UIViewAnimationOptionAllowUserInteraction animations:^{
                self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, +degree);
                self.pokeball.center = CGPointMake(self.pokeball.center.x + x_dist, self.pokeball.center.y);

            } completion:^(BOOL finished) {
                [UIView animateWithDuration:shake_t delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, -degree);
                    self.pokeball.center = CGPointMake(self.pokeball.center.x - x_dist, self.pokeball.center.y);

                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:shake_t delay:wait_t options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, -degree);
                        self.pokeball.center = CGPointMake(self.pokeball.center.x - x_dist, self.pokeball.center.y);

                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:shake_t delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                            self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, +degree);
                            self.pokeball.center = CGPointMake(self.pokeball.center.x + x_dist, self.pokeball.center.y);

                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:shake_t delay:wait_t options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, +degree);
                                self.pokeball.center = CGPointMake(self.pokeball.center.x + x_dist, self.pokeball.center.y);

                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:shake_t delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    self.pokeball.transform = CGAffineTransformRotate(self.pokeball.transform, -degree);
                                    self.pokeball.center = CGPointMake(self.pokeball.center.x - x_dist, self.pokeball.center.y);

                                } completion:^(BOOL finished) {
                                    [self catch];
                                }];
                            }];
                            
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (void)catch {
    [UIView animateWithDuration:0.1 delay:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.pokeball.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.pokeball.alpha = 1.0;
        } completion:nil];
    }];
}

@end
