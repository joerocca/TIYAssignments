//
//  Bagel.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "Bagel.h"

@interface Bagel ()

@property SKNode *world;
//@property SKSpriteNode *bagel2;

@end


@implementation Bagel

+(id)bagelGenerator:(SKNode *)world
{
 
    Bagel *bagel = [Bagel spriteNodeWithImageNamed:@"Bagel"];
    bagel.name = @"bagel";
    bagel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bagel.size.width * 0.5 ];
    bagel.world = world;
    
//        SKSpriteNode *leftFoot = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 30)];
//        leftFoot.position = CGPointMake(-20, -70);
//        [toaster addChild:leftFoot];
//        leftFoot.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:leftFoot.size];
//        leftFoot.physicsBody.dynamic = YES;
//        SKSpriteNode *rightFoot = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 30)];
//        rightFoot.position = CGPointMake(20, -70);
//        [toaster addChild:rightFoot];
//        rightFoot.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:rightFoot.size];
//        [toaster addChild:rightFoot];
    
    return bagel;
    
}

- (void)populate
{
    for (int i = 0; i < 3; i++)
    {
        [self generate];
    }
}

- (void)generate
{
    Bagel *bagel = [Bagel spriteNodeWithImageNamed:@"Bagel"];
    bagel.name = @"bagel";
    bagel.position = CGPointMake(-20, -self.scene.frame.size.height/3);
    bagel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bagel.size.width * 0.5 ];
    bagel.physicsBody.dynamic = YES;
    
    [self.world addChild:bagel];
}


- (void)chase
{
    SKAction *incrementRight = [SKAction moveByX:1.0 y:0 duration:0.0009];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
    SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
    SKAction *clockwiseRotationForever = [SKAction repeatActionForever:rotateClockwise];
    [self runAction:clockwiseRotationForever];
}

@end
