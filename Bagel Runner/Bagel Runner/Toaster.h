//
//  Toaster.h
//  Bagel Runner
//
//  Created by Joe Rocca on 4/16/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Toaster : SKSpriteNode

+(id)toaster;

- (void)toasterJump;
//- (void)runRight;
- (void)start;

-(void)stop;

- (void)rollingAnimation:(NSArray *)toasterImageArray;
@end
