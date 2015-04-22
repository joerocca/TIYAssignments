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
    NSArray *_toasterWalkingFrames;
    Toaster *toaster;
    Bagel *bagel;
    SKNode *world;
    WorldGenerator *generator;
    BOOL shouldJump;
    BOOL shouldJump2;
}

static NSString *GAME_FONT = @"Chalkduster";


-(void)didMoveToView:(SKView *)view
{
    shouldJump = YES;
    shouldJump2 = YES;
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Bagel Runner Beta Song MP3" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    
 
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.backgroundColor = [SKColor colorWithRed:0.54 green:0.7853 blue:1.0 alpha:1.0];
    self.physicsWorld.contactDelegate = self;
    
    world = [SKNode node];
    [self addChild:world];
    
    
    generator = [WorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate];
    
    toaster = [Toaster toaster];
    NSMutableArray *rollFrames = [NSMutableArray array];
    
    SKTextureAtlas *toasterAnimatedAtlas = [SKTextureAtlas atlasNamed:@"toasterImages"];
    
    int numImages = (int)toasterAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages/3; i++) {
        NSString *textureName = [NSString stringWithFormat:@"3DToaster%d", i];
        SKTexture *temp = [toasterAnimatedAtlas textureNamed:textureName];
        [rollFrames addObject:temp];
    } _toasterWalkingFrames = rollFrames;
    
    [toaster rollingAnimation:_toasterWalkingFrames];
    [world addChild:toaster];
//    [toaster breathe];
    
//    bagel = [Bagel bagel];
//    [world addChild:bagel];
    
    bagel = [Bagel bagelGenerator:world];
    
    PointsLabel *pointsLabel = [PointsLabel pointsLabelWithFontNamed:GAME_FONT];
    pointsLabel.position = CGPointMake(400, 200);
    [self addChild:pointsLabel];
    
    SKLabelNode *tapToBeginLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToBeginLabel.name = @"tapToBeginLabel";
    tapToBeginLabel.text = @"Tap to Begin";
    tapToBeginLabel.fontSize = 60;
    [self addChild:tapToBeginLabel];
    [tapToBeginLabel runAction:[self blinkAnimation]];
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

#pragma mark -- StartGameClearGameOver

- (void)start
{
    self.isStarted = YES;
    [[self childNodeWithName:@"tapToBeginLabel"] removeFromParent];
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

#pragma mark -- Extras

- (void)didSimulatePhysics
{
    [self centerOnNode:toaster];
//    [self handleGeneration]; //fixed fps bug by commenting this out 
    [self handleCleanup];
//    [self handlePoints];
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
        if (node.position.x < toaster.position.x - self.frame.size.width/2  - node.frame.size.width/1.2)
        {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"bagel" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x > toaster.position.x + self.frame.size.width/2)
        {
            [node removeFromParent];
//            [bagel generateTimer];
            [self handlePoints];
        }
    }];
}

- (void)handlePoints
{
    
//    [world enumerateChildNodesWithName:@"bagel" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.x > toaster.position.x && node.position.x < toaster.position.x + 16)
//        {
    //            difficultyInt ++;
    //        }
    //    }];
    
    if (self.isGameOver == NO && self.isStarted)
    {
        
            PointsLabel *pointsLabel = (PointsLabel *)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
    }


}



- (void)centerOnNode:(SKNode *)node
{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x + 100, world.position.y);
}


#pragma mark -- Built in Methods

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
        [world enumerateChildNodesWithName:@"bagel2" usingBlock:^(SKNode *node, BOOL *stop) {
         
                [node removeFromParent];
                //            [bagel generateTimer];
               
            
        }];
        
    }
    else
    {
       
            
                
            
//
//        if (shouldJump)
//        {
//        [toaster toasterJump];
//        shouldJump = NO;
//        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(setYes) userInfo:nil repeats:NO];
//        }
//        else
        
            if (toaster.position.y < -30.f)
        {
            NSLog(@"%f",toaster.position.y);
            [toaster toasterJump];
            
            if (toaster.position.y > -150.f)
            {
                SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
                [toaster runAction:rotateClockwise];
            }
//            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setYes) userInfo:nil repeats:NO];
//            shouldJump2 = NO;
        }
        
//        else if (shouldJump2)
//        {
//        [toaster toasterJump];
//            if (toaster.position.y > - 180)
//            {
//        SKAction *rotateClockwise = [SKAction rotateByAngle:-2*M_PI duration:0.7];
//        [toaster runAction:rotateClockwise];
//                
//            }
//            
//        shouldJump2 = NO;
//        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(setYes) userInfo:nil repeats:NO];
//        
//        }
//        else
//        {
//            [toaster toasterJump];  //temporary else
//        }
    
    
    }
    //    [bagel generate];
    //    [bagel chase];
//    [toaster runRight];
    
    
}



- (void)setYes
{

    shouldJump2 = YES;
    shouldJump = YES;
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:[SKAction playSoundFileNamed:@"toaster-up-1.mp3" waitForCompletion:NO]];
}

-(SKAction *)blinkAnimation
{
    double duration = 0.5;
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:duration];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:duration];
    SKAction *blinkText = [SKAction sequence:@[fadeOut,fadeIn]];
    return [SKAction repeatActionForever:blinkText];
}




- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 2) {
        self.lastSpawnTimeInterval = 0;
//        NSLog(@"%i",difficultyInt);
        if (self.isGameOver == NO && self.isStarted)
        {
            [bagel generateTimer];
        }
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
//    [bagel generateTimer2];
    NSLog(@"Did begin contact");
}



@end
