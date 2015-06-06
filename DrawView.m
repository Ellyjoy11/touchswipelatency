//
//  DrawView.m
//  TouchLatencyMeter2
//
//  Created by Elena Last on 10/5/14.
//  Copyright (c) 2014 Elena Last. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f}; // RGB color: red, green, blue, alpha - from 0.0 to 1.0
    CGContextSetStrokeColor(c, white);
    CGContextSetFillColor(c, white);
    CGContextSetLineWidth(c, 1);
    CGContextBeginPath(c);
    float centerX = rect.size.width/2;
    float upperY = 0.45 * rect.size.height;
    float lowerY = 0.8 * rect.size.height;

    //CGContextBeginPath(c);
    CGContextMoveToPoint(c, centerX, 5);
    CGContextAddLineToPoint(c, centerX, rect.size.height - 5);
    CGContextStrokePath(c);
    
    //CGContextBeginPath(c);
    CGContextMoveToPoint(c, 5, upperY);
    CGContextAddLineToPoint(c, rect.size.width - 5, upperY);
    CGContextStrokePath(c);
    
    //CGContextBeginPath(c);
    CGPoint center = CGPointMake(centerX, lowerY); // get the circle centre
    CGFloat radius = 0.25 * center.x; // little scaling needed
    CGFloat startAngle = -((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = ((2 * (float)M_PI) + startAngle);
    CGContextAddArc(c, center.x, center.y, radius, startAngle, endAngle, 0); // create an arc the +4 just adds some pixels because of the polygon line thickness
    CGContextFillPath(c); // draw
}



@end
