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
    pointsLabel.text = @"0";
    return pointsLabel;
}



@end

