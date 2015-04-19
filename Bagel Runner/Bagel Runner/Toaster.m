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
    toaster.position = CGPointMake(200, 0);
    
    CGFloat offsetX = toaster.frame.size.width * toaster.anchorPoint.x;
    CGFloat offsetY = toaster.frame.size.height * toaster.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 28 - offsetX, 25 - offsetY);
    CGPathAddLineToPoint(path, NULL, 44 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 134 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 134 - offsetX, 55 - offsetY);
    CGPathAddLineToPoint(path, NULL, 123 - offsetX, 74 - offsetY);
    CGPathAddLineToPoint(path, NULL, 28 - offsetX, 74 - offsetY);
    
    CGPathCloseSubpath(path);
    
    toaster.physicsBody =[SKPhysicsBody bodyWithPolygonFromPath:path];
    
//    toaster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toaster.size];
    
    
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
    [self.physicsBody applyImpulse:CGVectorMake(0, 200)];
//    SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
//    [self runAction:rotateClockwise];
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
