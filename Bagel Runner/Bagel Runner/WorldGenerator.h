//
//  WorldGenerator.h
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WorldGenerator : SKNode

+ (id)generatorWithWorld:(SKNode *)world;
- (void)populate;
- (void)generate;
@end
