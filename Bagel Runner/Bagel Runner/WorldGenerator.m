//
//  WorldGenerator.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "WorldGenerator.h"

static const uint32_t groundCategory = 0x1 << 2;

@interface WorldGenerator ()

@property double currentGroundX;
@property double currentObstacleX;
@property SKNode *world;

@end

@implementation WorldGenerator

+ (id)generatorWithWorld:(SKNode *)world
{
    WorldGenerator *worldGenerator = [WorldGenerator node];
    worldGenerator.currentGroundX = 0;
    worldGenerator.currentObstacleX = 400;
    worldGenerator.world = world;
    return worldGenerator;
}

#pragma mark -- Actions

- (void)populate
{
    for (int i = 0; i < 3; i++)
    {
        [self generate];
    }
}

- (void)generate
{
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[self randomColor] size:CGSizeMake(self.scene.frame.size.width + 50000000, 50)]; //fixed fps bug by changing -850 to + 50000000
    ground.name = @"ground";
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2.94);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.physicsBody.dynamic = NO;
//    NSLog(@"%f",-self.frame.size.height/3);
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
}



-(UIColor *)randomColor
{

    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
            
//    }
    
    return color;
}

@end
