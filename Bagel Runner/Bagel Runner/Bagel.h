//
//  Bagel.h
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bagel : SKSpriteNode

+(id)bagelGenerator:(SKNode *)world;

- (void)chase;

- (void)populate;

- (void)generateTimer;

- (void)generate;

- (void)generateTimer2;

- (void)generate2;

- (void)chase2;


-(void)stop;

- (void)incrementDifficultyInt;

@end
