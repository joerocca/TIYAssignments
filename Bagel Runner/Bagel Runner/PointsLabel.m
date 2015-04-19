//
//  PointsLabel.m
//  Bagel Runner
//
//  Created by Joe Rocca on 4/17/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "PointsLabel.h"

@implementation PointsLabel

+(id)pointsLabelWithFontNamed:(NSString *)fontName
{
    PointsLabel *pointsLabel = [PointsLabel labelNodeWithFontNamed:fontName];
    pointsLabel.name = @"pointsLabel";
    pointsLabel.text = @"0";
    pointsLabel.score = 0;
    pointsLabel.fontSize = 65;
    return pointsLabel;
}


- (void)increment
{
    self.score ++;
    self.text = [NSString stringWithFormat:@"%i",self.score];
}

- (void)setPoints:(int)points
{
    self.score = points;
    self.text = [NSString stringWithFormat:@"%i",self.score];
}

- (void)reset
{
    self.score = 0;
    self.text = @"0";
}

@end

