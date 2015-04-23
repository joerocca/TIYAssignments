//
//  Bagel.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "Bagel.h"
#import "Toaster.h"
#import "PointsLabel.h"
#import "GameScene.h"

static const uint32_t bagelCategory = 0x1 << 1;

@interface Bagel ()

@property SKNode *world;
//@property SKSpriteNode *bagel2;

@end


@implementation Bagel
{
     Toaster *toaster;
    PointsLabel *pointsLabel;
    NSTimer *bagelGenerateTimer;
    BOOL stopGenerate;
    GameScene *gameScene;

}

+(id)bagelGenerator:(SKNode *)world
{
    
    
    Bagel *bagel = [Bagel spriteNodeWithImageNamed:@"Bagel"];
//    bagel.name = @"bagel";
//    bagel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bagel.size.width * 0.5 ];
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

//- (void)populate
//{
//    for (int i = 0; i < 3; i++)
//    {
//        [self generate];
//    }
//}






- (void)generateTimer
{
    if (stopGenerate == NO)
    {
       
    
        
    bagelGenerateTimer = [NSTimer scheduledTimerWithTimeInterval:arc4random_uniform(10)+1
                                                  target:self
                                                selector:@selector(generate)
                                                userInfo:nil
                                                 repeats:NO];
        
    }
}

- (void)generate
{
    
    toaster = [Toaster toaster];
    
    Bagel *bagel = [Bagel spriteNodeWithImageNamed:@"Bagel"];
    bagel.name = @"bagel";
    [self.world enumerateChildNodesWithName:@"toaster" usingBlock:^(SKNode *node, BOOL *stop) {
      
            bagel.position = CGPointMake(node.position.x - 500, -self.world.scene.frame.size.height/3);
    }];
    bagel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bagel.size.width * 0.5 ];
    bagel.physicsBody.categoryBitMask = bagelCategory;
    [self.world addChild:bagel];
    [bagel chase];
    
}


- (void)chase
{
//    NSLog(@"%f",arc4random_uniform(4) * 0.0001 + 0.0005);
    
//    float speed = arc4random_uniform(3) * 0.0001 + 0.0004;
//    float increment = 0.0001;
//    
//    if (speed == 0.0004)
//        speed = + 0.0001;
    
//    
//      NSLog(@"%f",speed);
    
    
    
    

   

    SKAction *incrementRight = [SKAction moveByX:1.0 y:0 duration:0.0006];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
    
    SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:1];
    SKAction *clockwiseRotationForever = [SKAction repeatActionForever:rotateClockwise];
    [self runAction:clockwiseRotationForever];
        
       
 
    

    
   
}

- (void)generateTimer2
{
//    [self.world enumerateChildNodesWithName:@"bage" usingBlock:^(SKNode *node, BOOL *stop) {
//        
//        bagel.position = CGPointMake(node.position.x + arc4random_uniform(300) - 150, self.world.scene.frame.size.height/3);
//    }];

   
        bagelGenerateTimer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                              target:self
                                                            selector:@selector(generate2)
                                                            userInfo:nil
                                                             repeats:YES];
    
        
    
    
    
}

- (void)generate2
{
    
    
//    toaster = [Toaster toaster];
    
    Bagel *bagel = [Bagel spriteNodeWithImageNamed:@"Bagel"];
    bagel.name = @"bagel2";
    [self.world enumerateChildNodesWithName:@"toaster" usingBlock:^(SKNode *node, BOOL *stop) {
        
        bagel.position = CGPointMake(node.position.x + arc4random_uniform(500) - 250, self.world.scene.frame.size.height/3);
    }];
    bagel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bagel.size.width * 0.5 ];
//    bagel.physicsBody.categoryBitMask = bagelCategory;
    [self.world addChild:bagel];
//    [bagel chase2];
    
    
    
//    if ([self.world.children count] == 10)
//    {
//        [bagelGenerateTimer invalidate];
//    }
//    
}





-(void)stop
{
    [self removeAllActions];
    [self enumerateChildNodesWithName:@"bagel" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    if (stopGenerate == NO)
    {
        [self generateTimer2];
    }
    stopGenerate = YES;
    
}

@end
