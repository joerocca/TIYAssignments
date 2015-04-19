//
//  GameScene.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/16/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "GameScene.h"
#import "Toaster.h"
#import "Bagel.h"
#import "PointsLabel.h"
#import "WorldGenerator.h"

@interface GameScene()

@property BOOL isStarted;
@property BOOL isGameOver;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene
{
    Toaster *toaster;
    Bagel *bagel;
    SKNode *world;
    WorldGenerator *generator;
}

-(void)didMoveToView:(SKView *)view
{
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor colorWithRed:0 green:3.0 blue:10 alpha:1.0];
    
    world = [SKNode node];
    [self addChild:world];
    
    
    generator = [WorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate];
    
    toaster = [Toaster toaster];
    [world addChild:toaster];
//    [toaster breathe];
    
//    bagel = [Bagel bagel];
//    [world addChild:bagel];
    
    bagel = [Bagel bagelGenerator:world];
    
    PointsLabel *pointsLabel = [PointsLabel pointsLabelWithFontNamed:@"Helvetica-Light"];
    pointsLabel.position = CGPointMake(400, 200);
    [self addChild:pointsLabel];
//    bagel.position = CGPointMake(-300, -self.scene.frame.size.height/3);
//    [world addChild:bagel];
    
//    [bagel populate];
    
    /* Setup your scene here */
//    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    
//    myLabel.text = @"Hello, World!";
//    myLabel.fontSize = 65;
//    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame));
//    
//    [self addChild:myLabel];
}

- (void)start
{
    self.isStarted = YES;
    [toaster start];
}

- (void)clear
{
    NSLog(@"Clear method called.");
}

- (void)gameOver
{
    NSLog(@"Game over method called.");
}

- (void)didSimulatePhysics
{
    [self centerOnNode:toaster];
    [self handleGeneration];
    [self handleCleanup];
    [self handlePoints];
}

- (void) handleGeneration
{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < toaster.position.x) {
//            node.name = @"ground_cancelled";
            [generator generate];
        }
    }];
}

- (void) handleCleanup
{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < toaster.position.x - self.frame.size.width/2  - node.frame.size.width/2)
        {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"bagel" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x > toaster.position.x + self.frame.size.width/2)
        {
            [node removeFromParent];
//            [bagel generateTimer];
        }
    }];
}

- (void)handlePoints
{
    
    [world enumerateChildNodesWithName:@"bagel" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x > toaster.position.x && node.position.x < toaster.position.x + 16)
        {
            PointsLabel *pointsLabel = (PointsLabel *)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
            
        }
    }];

}



- (void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    
    
    if (!self.isStarted)
    {
        [self start];
        [bagel generateTimer];
    }
    else if (self.isGameOver)
    {
        [self clear];
    }
    else
    {
//    [bagel generate];
    
    [bagel chase];
    [toaster toasterJump];
    }
//    [toaster runRight];
    
    
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1) {
        self.lastSpawnTimeInterval = 0;
        [bagel generateTimer];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

@end
