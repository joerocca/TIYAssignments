//
//  PointsLabel.h
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PointsLabel : SKLabelNode

@property int score;

+(id)pointsLabelWithFontNamed:(NSString *)fontName;
- (void)increment;

@end
