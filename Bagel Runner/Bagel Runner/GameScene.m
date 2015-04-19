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
#import "GameViewController.h"

@import AVFoundation;

@interface GameScene()

@property BOOL isStarted;
@property BOOL isGameOver;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;

@end

@implementation GameScene
{
    Toaster *toaster;
    Bagel *bagel;
    SKNode *world;
    WorldGenerator *generator;
    GameViewController *view;
    BOOL shouldJump;
    BOOL shouldJump2;
    int difficultyInt;
}

static NSString *GAME_FONT = @"Chalkduster";

-(void)didMoveToView:(SKView *)view
{
    shouldJump = YES;
    shouldJump2 = YES;
    difficultyInt = 0;
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Bagel Runner Beta Song MP3" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor colorWithRed:0 green:3.0 blue:10 alpha:1.0];
    self.physicsWorld.contactDelegate = self;
    
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
    
    PointsLabel *pointsLabel = [PointsLabel pointsLabelWithFontNamed:GAME_FONT];
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
    [self removeAllChildren];
    GameScene *newGameScene = [[GameScene alloc] initWithSize:self.frame.size];
    newGameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:newGameScene];
    
  
    NSLog(@"Clear method called.");
}

- (void)gameOver
{
    NSLog(@"Game over method called.");
    self.isGameOver = YES;
    [toaster stop];
    [bagel stop];
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 70;
    [self addChild:gameOverLabel];
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
        if (node.position.x > toaster.position.x && node.position.x < toaster.position.x + 15)
        {
            PointsLabel *pointsLabel = (PointsLabel *)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
            difficultyInt ++;
        }
    }];

}



- (void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x + 35, world.position.y);
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
        

        if (shouldJump)
        {
        [toaster toasterJump];
        shouldJump = NO;
//        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(setNO) userInfo:nil repeats:NO];
        }
        else if (shouldJump2)
        {
        [toaster toasterJump];
            if (toaster.position.y > - 170)
            {
        SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
        [toaster runAction:rotateClockwise];
            }
        shouldJump2 = NO;
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(setNO) userInfo:nil repeats:NO];
        
        }
    
    }
    //    [bagel generate];
    //    [bagel chase];
//    [toaster runRight];
    
    
}



- (void)setNO
{
    shouldJump2 = true;
    shouldJump = true;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:[SKAction playSoundFileNamed:@"toaster-up-1.mp3" waitForCompletion:NO]];
}






- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 2) {
        self.lastSpawnTimeInterval = 0;
        NSLog(@"%i",difficultyInt);
//        if (difficultyInt < 15)
//        {
            [bagel generateTimer];
//        }
//        else
//        {
//            [bagel generateTimer2];
//        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 2) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    [self gameOver];
    NSLog(@"Did begin contact");
}



@end
