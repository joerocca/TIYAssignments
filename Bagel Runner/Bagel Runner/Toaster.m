//
//  Toaster.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/16/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "Toaster.h"

@implementation Toaster


+(id)toaster
{
    
    Toaster *toaster = [Toaster spriteNodeWithImageNamed:@"Toaster"];
    toaster.name = @"toaster";
    toaster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toaster.size];
    
    
//    SKSpriteNode *leftFoot = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 30)];
//    leftFoot.position = CGPointMake(-20, -70);
//    [toaster addChild:leftFoot];
//    leftFoot.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:leftFoot.size];
//    leftFoot.physicsBody.dynamic = YES;
//    SKSpriteNode *rightFoot = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 30)];
//    rightFoot.position = CGPointMake(20, -70);
//    [toaster addChild:rightFoot];
//    rightFoot.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:rightFoot.size];
//    [toaster addChild:rightFoot];
    
    return toaster;

}

//- (void)runRight
//{
//    SKAction *runright = [SKAction moveByX:10 y:0 duration:0];
//    [self runAction:runright];
//}


- (void)toasterJump
{
    [self.physicsBody applyImpulse:CGVectorMake(0, 350)];
    SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
    //    SKAction *clockwiseRotationForever = [SKAction repeatActionForever:rotateClockwise];
    [self runAction:rotateClockwise];
}

//- (void)breathe
//{
//    SKAction *breatheOut = [SKAction moveByX:0 y:-2 duration:0.5];
//    SKAction *breatheIn = [SKAction moveByX:0 y:2 duration:0.5];
//    SKAction *breathe = [SKAction sequence:@[breatheOut, breatheIn]];
//    [self runAction:[SKAction repeatActionForever:breathe]];
//}


- (void)start
{
    SKAction *incrementRight = [SKAction moveByX:1.0 y:0 duration:0.001];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
   
}

- (void)runningAnimation
{
    
}



@end
